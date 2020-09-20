<?php

class ControllerCheckoutSendRequest extends Controller
{
    public function index()
    {
        $email = $this->request->post['email'];
        $text = '<html><head></head><body><h3>Заказ для ' . $email . '</h3><table><tr><th>Имя</th><th>Модель</th>' .
            '<th>Кол-во</th><th>Цена за шт.</th><th>Итого</th></tr>';
        $products = $this->cart->getProducts();

        $overall = 0;
        foreach ($products as $product) {
            $text .= '<tr>';
            $product_total = 0;

            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }

            $unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));

            $price = $this->currency->format($unit_price, $this->session->data['currency']);
            $total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
            $overall += $unit_price * $product['quantity'];

            $text .= '<td>' . $product['name'] . '</td>';
            $text .= '<td>' . $product['model'] . '</td>';
            $text .= '<td>' . $product['quantity'] . '</td>';
            $text .= '<td>' . $price . '</td>';
            $text .= '<td>' . $total . '</td></tr>';
        }

        $text .= '</table><br/><br/>';
        $text .= '<strong>Итого: ' . $this->currency->format($overall, $this->session->data['currency']) . '</strong>';

        $c = $this->config;
        $mail = new Mail();
        $mail->protocol = $c->get('config_mail_protocol');
        $mail->parameter = $c->get('config_mail_parameter');
        $mail->smtp_hostname = $c->get('config_mail_smtp_hostname');
        $mail->smtp_username = $c->get('config_mail_smtp_username');
        $mail->smtp_password = html_entity_decode($c->get('config_mail_smtp_password'));
        $mail->smtp_port = $c->get('config_mail_smtp_port');
        $mail->smtp_timeout = $c->get('config_mail_smtp_timeout');

        $mail->setTo($c->get('config_email'));
        $mail->setSender($email);
        $mail->setFrom($email);
        $mail->setSubject('Заказ с сайта');
        $mail->setHtml($text);

        try {
            $mail->send();
        } catch (\Exception $e) {
            $this->log->write('Error while sending email: ' .$e->getMessage());
            $this->session->data['error_warning'] = "Возникла внутренняя ошибка и ваша заявка не была отправлена.\n".
                'Перезвоните нам, и мы с радостью примем вашу заявку по телефону.';
        }

        $this->session->data['success'] = "Ваша заявка принята. Мы скоро вам перезвоним!";

        $this->response->redirect($this->url->link('checkout/cart'));
    }
}

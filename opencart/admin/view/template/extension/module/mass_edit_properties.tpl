<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
        <div class="modal fade" id="modal_properties">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
              <h4 class="modal-title">Edit Properties</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="form_product_edit">
                    <div data-bind="foreach: selectedProducts, visible: selectedProducts().length > 0">
                        <h3 data-bind="text: name"></h3>
                        <div data-bind="foreach: $root.selectedProperties, visible: $root.selectedProperties().length > 0">
                            <label data-bind="text: name"></label>
                            <div data-bind="if: display_input">
                                <div data-bind="template: { name: 'prod_form_input_template'}"></div>
                            </div>
                            <script type="text/html" id="prod_form_input_template">
                                <input class="form-control" data-bind="textInput:$parent[property_name]" />
                            </script>
                            
                            <div data-bind="if: display_textarea">
                                <div data-bind="template: { name: 'prod_form_textarea_template'}"></div>
                            </div>
                            <script type="text/html" id="prod_form_textarea_template">
                                <textarea class="form-control" data-bind="textInput: $parent[property_name]"></textarea>
                            </script>
                        </div>
                        <hr>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <span class="label label-success" data-bind="fadeVisible: saveSuccess">Successfully saved!</span>
                <span class="label label-danger" data-bind="fadeVisible: saveFail">Error saving. Please try again.</span>
                <span class="fa fa-3x fa-spinner fa-spin" data-bind="visible: saving"></span>
                <button class="btn btn-default" data-bind="click: saveChanges">Save Changes</button>
            </div>
          </div>
        </div>
      </div>
      <div class="pull-right">
          <button data-toggle="tooltip" title="<?php echo $button_select_all_products; ?>" data-bind="click: selectAll" class="btn btn-default"><i class="fa fa-check-square-o"></i> <?php echo $button_select_all_products; ?></button>
        <button data-toggle="tooltip" title="<?php echo $button_deselect_all_products; ?>" data-bind="click: deselectAll" class="btn btn-default"><i class="fa fa-square-o"></i> <?php echo $button_deselect_all_products; ?></button>
        <button data-toggle="modal" data-target="#modal_properties" title="<?php echo $button_edit_selected; ?>" class="btn btn-default"><i class="fa fa-pencil"></i> <?php echo $button_edit_selected; ?></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
                <script type='text/javascript' src='//cdnjs.cloudflare.com/ajax/libs/knockout/3.3.0/knockout-min.js'></script>
                <h3>Properties to Edit</h3>
                <div class="btn-group">
                    <button data-toggle="tooltip" title="<?php echo $button_select_all_properties; ?>" data-bind="click: selectAllProperties" class="btn btn-default"><i class="fa fa-check-square-o"></i> Select All Properties</button>
                    <button data-toggle="tooltip" title="<?php echo $button_deselect_all_properties; ?>" data-bind="click: deselectAllProperties" class="btn btn-default"><i class="fa fa-square-o"></i> Deselect All Properties</button>
                </div>
                <ul style="padding: 0;list-style: none;width: 921px;">
                    <li data-bind="foreach: properties, visible: properties().length > 0">
                        <span class="inline ditem"><input type='checkbox' data-bind="checked: selected" /><span data-bind="text: name"></span> | </span>
                    </li>
                </ul>
                <h3>Products</h3>
                You have <b data-bind="text: selectedProducts().length">&nbsp;</b> product(s) selected
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <td></td>
                            <td>Product Name</td>
                            <td>Price</td>
                            <td>Model</td>
                        </tr>
                    </thead>
                    <tbody data-bind="foreach: products, visible: products().length > 0">
                    <tr>
                        <td><input type="checkbox" data-bind="checked: selected"/></td>
                        <td><span data-bind="text: name" /></span></td>
                        <td><span data-bind="text: price" /></span></td>
                        <td><span data-bind="text: model" /></span></td>
                    </tr>
                    </tbody>
                </table>
                <script>
                    function Property(e){this.name=e.name,this.input_type=e.input_type?e.input_type:null,this.property_name=e.property_name,this.property_type=e.property_type,this.selected=ko.observable(!1),this.display_input=e.display_input,this.display_textarea=e.display_textarea}function Product(e){this.id=ko.observable(e.product_id),this.name=ko.observable(e.name),this.description=ko.observable(e.description),this.keyword=ko.observable(e.keyword),this.price=ko.observable(e.price),this.model=ko.observable(e.model),this.tag=ko.observable(e.tag),this.meta_title=ko.observable(e.meta_title),this.meta_keyword=ko.observable(e.meta_keyword),this.meta_description=ko.observable(e.meta_description),this.points=ko.observable(e.points),this.subtract=ko.observable(e.subtract),this.minimum=ko.observable(e.minimum),this.quantity=ko.observable(e.quantity),this.sort_order=ko.observable(e.sort_order),this.ean=ko.observable(e.xtras.ean),this.height=ko.observable(e.xtras.height),this.isbn=ko.observable(e.xtras.isbn),this.jan=ko.observable(e.xtras.jan),this.language_id=ko.observable(e.xtras.language_id),this.length=ko.observable(e.xtras.length),this.location=ko.observable(e.xtras.location),this.mpn=ko.observable(e.xtras.mpn),this.sku=ko.observable(e.xtras.sku),this.upc=ko.observable(e.xtras.upc),this.weight=ko.observable(e.xtras.weight),this.width=ko.observable(e.xtras.width),this.selected=ko.observable(!1)}function ProductListViewModel(){var e=this;e.saving=ko.observable(!1),e.saveSuccess=ko.observable(!1),e.saveFail=ko.observable(!1),e.products=ko.observableArray([]),e.properties=ko.observableArray([new Property({name:"Name",display_input:!0,input_type:"text",property_name:"name",property_type:"description_property"}),new Property({name:"Description",display_textarea:!0,property_name:"description",property_type:"description_property"}),new Property({name:"Product Tags",display_input:!0,input_type:"text",property_name:"tag",property_type:"description_property"}),new Property({name:"Meta Title",display_input:!0,input_type:"text",property_name:"meta_title",property_type:"description_property"}),new Property({name:"Meta Description",display_textarea:!0,property_name:"meta_description",property_type:"description_property"}),new Property({name:"Meta Keyword",display_input:!0,input_type:"text",property_name:"meta_keyword",property_type:"description_property"}),new Property({name:"SEO Keyword",display_input:!0,input_type:"text",property_name:"keyword"}),new Property({name:"Subtract Stock",display_input:!0,input_type:"text",property_name:"subtract",property_type:"detail_property"}),new Property({name:"Reward Points",display_input:!0,input_type:"text",property_name:"points",property_type:"detail_property"}),new Property({name:"Price",display_input:!0,input_type:"text",property_name:"price",property_type:"detail_property"}),new Property({name:"Model",display_input:!0,input_type:"text",property_name:"model",property_type:"detail_property"}),new Property({name:"Quantity",display_input:!0,input_type:"text",property_name:"quantity",property_type:"detail_property"}),new Property({name:"Minimum",display_input:!0,input_type:"text",property_name:"minimum",property_type:"detail_property"}),new Property({name:"Sort Order",display_input:!0,input_type:"text",property_name:"sort_order",property_type:"detail_property"}),new Property({name:"EAN",display_input:!0,input_type:"text",property_name:"ean",property_type:"detail_property"}),new Property({name:"Height",display_input:!0,input_type:"text",property_name:"height",property_type:"detail_property"}),new Property({name:"ISBN",display_input:!0,input_type:"text",property_name:"isbn",property_type:"detail_property"}),new Property({name:"JAN",display_input:!0,input_type:"text",property_name:"jan",property_type:"detail_property"}),new Property({name:"Length",display_input:!0,input_type:"text",property_name:"length",property_type:"detail_property"}),new Property({name:"Location",display_input:!0,input_type:"text",property_name:"location",property_type:"detail_property"}),new Property({name:"MPN",display_input:!0,input_type:"text",property_name:"mpn",property_type:"detail_property"}),new Property({name:"SKU",display_input:!0,input_type:"text",property_name:"sku",property_type:"detail_property"}),new Property({name:"UPC",display_input:!0,input_type:"text",property_name:"upc",property_type:"detail_property"}),new Property({name:"Weight",display_input:!0,input_type:"text",property_name:"weight",property_type:"detail_property"}),new Property({name:"Width",display_input:!0,input_type:"text",property_name:"width",property_type:"detail_property"})]),e.selectedProperties=ko.computed(function(){return ko.utils.arrayFilter(e.properties(),function(e){return e.selected()&&!e._destroy})}),e.selectAllProperties=function(){for(var t=0;t<e.properties().length;t++)e.properties()[t].selected(!0)},e.deselectAllProperties=function(){for(var t=0;t<e.properties().length;t++)e.properties()[t].selected(!1)},e.selectedProducts=ko.computed(function(){return ko.utils.arrayFilter(e.products(),function(e){return e.selected()&&!e._destroy})}),e.selectAll=function(){for(var t=0;t<e.products().length;t++)e.products()[t].selected(!0)},e.deselectAll=function(){for(var t=0;t<e.products().length;t++)e.products()[t].selected(!1)},e.toBeUpdated=ko.computed(function(){for(var t=[],r=0;r<e.selectedProducts().length;r++){for(var p={id:e.selectedProducts()[r].id(),language_id:e.selectedProducts()[r].language_id(),detail_properties:{},description_properties:{}},o=0;o<e.selectedProperties().length;o++)switch(e.selectedProperties()[o].property_type){case"description_property":p.description_properties[e.selectedProperties()[o].property_name]=e.selectedProducts()[r][e.selectedProperties()[o].property_name]();break;case"detail_property":p.detail_properties[e.selectedProperties()[o].property_name]=e.selectedProducts()[r][e.selectedProperties()[o].property_name]();break;default:p[e.selectedProperties()[o].property_name]=e.selectedProducts()[r][e.selectedProperties()[o].property_name]()}t.push(p)}return t}),e.saveChanges=function(){e.saving(!0),$.post("index.php?route=extension/module/mass_edit_properties/updateProducts&token=<?php echo $token?>",{products:e.toBeUpdated()}).done(function(t){for(var r=0,p=0;p<t.length;p++)t[p].description&&1===t[p].description||t[p].details&&1===t[p].details?r++:0===t[p].description||0===t[p].description;r===t.length?(e.saveSuccess(!0),e.saveSuccess(!1)):(e.saveFail(!0),e.saveFail(!1)),e.saving(!1)})},$.getJSON("index.php?route=extension/module/mass_edit_properties/getAll&token=<?php echo $token; ?>",function(t){var r=$.map(t,function(e){return new Product(e)});e.products(r)})}var plvm=new ProductListViewModel;ko.bindingHandlers.fadeVisible={init:function(e,t){var r=t();$(e).toggle(ko.unwrap(r))},update:function(e,t){var r=t();ko.unwrap(r)?$(e).fadeIn():$(e).fadeOut(1500)}},ko.applyBindings(plvm);
                </script>
            </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
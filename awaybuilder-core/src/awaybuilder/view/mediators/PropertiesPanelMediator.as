package awaybuilder.view.mediators
{
    import away3d.entities.Mesh;
    
    import awaybuilder.controller.document.events.ImportTextureEvent;
    import awaybuilder.controller.events.DocumentModelEvent;
    import awaybuilder.controller.scene.events.SceneEvent;
    import awaybuilder.model.IDocumentModel;
    import awaybuilder.model.vo.scene.AssetVO;
    import awaybuilder.model.vo.scene.ContainerVO;
    import awaybuilder.model.vo.scene.EffectMethodVO;
    import awaybuilder.model.vo.scene.LightPickerVO;
    import awaybuilder.model.vo.scene.LightVO;
    import awaybuilder.model.vo.scene.MaterialVO;
    import awaybuilder.model.vo.scene.MeshVO;
    import awaybuilder.model.vo.scene.ShadowMethodVO;
    import awaybuilder.model.vo.scene.SubMeshVO;
    import awaybuilder.model.vo.scene.TextureVO;
    import awaybuilder.utils.AssetFactory;
    import awaybuilder.view.components.PropertiesPanel;
    import awaybuilder.view.components.editors.events.PropertyEditorEvent;
    
    import flash.utils.getTimer;
    
    import mx.collections.ArrayCollection;
    import mx.controls.Alert;
    
    import org.robotlegs.mvcs.Mediator;

    public class PropertiesPanelMediator extends Mediator
    {
        [Inject]
        public var view:PropertiesPanel;

        [Inject]
        public var document:IDocumentModel;

        override public function onRegister():void
        {
            addContextListener(SceneEvent.SELECT, eventDispatcher_itemsSelectHandler);
            addContextListener(SceneEvent.CHANGING, eventDispatcher_changingHandler);
            addContextListener(SceneEvent.TRANSLATE_OBJECT, eventDispatcher_translateHandler);
            addContextListener(SceneEvent.SCALE_OBJECT, eventDispatcher_translateHandler);
            addContextListener(SceneEvent.ROTATE_OBJECT, eventDispatcher_translateHandler);
            addContextListener(SceneEvent.CHANGE_MESH, eventDispatcher_changeMeshHandler);
			addContextListener(SceneEvent.CHANGE_LIGHT, eventDispatcher_changeLightHandler);
            addContextListener(SceneEvent.CHANGE_MATERIAL, eventDispatcher_changeMaterialHandler);
			addContextListener(SceneEvent.CHANGE_LIGHTPICKER, eventDispatcher_changeLightPickerHandler);
			
			addContextListener(SceneEvent.ADD_NEW_TEXTURE, eventDispatcher_addNewTextureHandler);
			addContextListener(SceneEvent.ADD_NEW_MATERIAL, eventDispatcher_addNewMaterialToSubmeshHandler);
			addContextListener(SceneEvent.ADD_NEW_LIGHTPICKER, eventDispatcher_addNewLightpickerToMaterialHandler);
			addContextListener(SceneEvent.ADD_NEW_LIGHT, eventDispatcher_addNewLightToLightpickerHandler);
			addContextListener(SceneEvent.ADD_NEW_SHADOW_METHOD, eventDispatcher_addNewMethodHandler);
			addContextListener(SceneEvent.ADD_NEW_EFFECT_METHOD, eventDispatcher_addNewMethodHandler);
			
			addContextListener(DocumentModelEvent.DOCUMENT_UPDATED, context_documentUpdatedHandler);

            addViewListener( PropertyEditorEvent.TRANSLATE, view_translateHandler );
            addViewListener( PropertyEditorEvent.ROTATE, view_rotateHandler );
            addViewListener( PropertyEditorEvent.SCALE, view_scaleHandler );
            addViewListener( PropertyEditorEvent.MESH_CHANGE, view_meshChangeHandler );
            addViewListener( PropertyEditorEvent.MESH_NAME_CHANGE, view_meshNameChangeHandler );
            addViewListener( PropertyEditorEvent.MESH_SUBMESH_CHANGE, view_meshSubmeshChangeHandler );
			addViewListener( PropertyEditorEvent.MESH_SUBMESH_ADD_NEW_MATERIAL, view_submeshAddNewMaterialHandler );
			
            addViewListener( PropertyEditorEvent.MATERIAL_CHANGE, view_materialChangeHandler );
            addViewListener( PropertyEditorEvent.MATERIAL_STEPPER_CHANGE, view_materialNameChangeHandler );
			
			addViewListener( PropertyEditorEvent.MATERIAL_ADD_TEXTURE, view_materialAddNewTextureHandler );
			addViewListener( PropertyEditorEvent.MATERIAL_ADD_EFFECT_METHOD, view_materialAddEffectMetodHandler );
			addViewListener( PropertyEditorEvent.MATERIAL_ADD_LIGHTPICKER, view_materialAddLightpickerHandler );
			addViewListener( PropertyEditorEvent.MATERIAL_REMOVE_EFFECT_METHOD, view_materialRemoveEffectMetodHandler );
			
			addViewListener( PropertyEditorEvent.SHADOWMETHOD_CHANGE, view_shadowmethodChangeHandler );
			addViewListener( PropertyEditorEvent.SHADOWMETHOD_STEPPER_CHANGE, view_shadowmethodChangeStepperHandler );
			addViewListener( PropertyEditorEvent.SHADOWMETHOD_ADD_LIGHT, view_shadowmethodAddLightHandler );
			
			addViewListener( PropertyEditorEvent.REPLACE_TEXTURE, view_replaceTextureHandler );
			
			addViewListener( PropertyEditorEvent.LIGHT_POSITION_CHANGE, view_lightPositionChangeHandler );
			addViewListener( PropertyEditorEvent.LIGHT_STEPPER_CHANGE, view_lightStepperChangeHandler );
			addViewListener( PropertyEditorEvent.LIGHT_CHANGE, view_lightChangeHandler );
			
			addViewListener( PropertyEditorEvent.LIGHT_ADD_FilteredShadowMapMethod, view_lightAddFilteredShadowMapMethodHandler );
			addViewListener( PropertyEditorEvent.LIGHT_ADD_CascadeShadowMapMethod, view_lightAddCascadeShadowMapMethodHandler );
			addViewListener( PropertyEditorEvent.LIGHT_ADD_DitheredShadowMapMethod, view_lightAddDitheredShadowMapHandler );
			addViewListener( PropertyEditorEvent.LIGHT_ADD_HardShadowMapMethod, view_lightAddHardShadowMapMethodHandler );
			addViewListener( PropertyEditorEvent.LIGHT_ADD_NearShadowMapMethod, view_lightAddNearShadowMapMethodHandler );
			addViewListener( PropertyEditorEvent.LIGHT_ADD_SoftShadowMapMethod, view_lightAddSoftShadowMapMethodHandler );
			
			addViewListener( PropertyEditorEvent.LIGHTPICKER_CHANGE, view_lightPickerChangeHandler );
			addViewListener( PropertyEditorEvent.LIGHTPICKER_STEPPER_CHANGE, view_lightPickerStepperChangeHandler );
			addViewListener( PropertyEditorEvent.LIGHTPICKER_ADD_LIGHT, view_lightPickerAddLightHandler );
			
			
			addViewListener( PropertyEditorEvent.SHOW_CHILD_PROPERTIES, view_showChildObjectPropertiesHandler );
			
			addViewListener( PropertyEditorEvent.SHOW_PARENT_MESH_PROPERTIES, view_showParentMeshHandler );
			addViewListener( PropertyEditorEvent.SHOW_PARENT_MATERIAL_PROPERTIES, view_showParentMaterialHandler );
			
			view.currentState = "empty";
        }

        //----------------------------------------------------------------------
        //
        //	view handlers
        //
        //----------------------------------------------------------------------


        private function view_translateHandler(event:PropertyEditorEvent):void
        {
            this.dispatch(new SceneEvent(SceneEvent.TRANSLATE_OBJECT,[view.data], event.data, true));
        }
        private function view_rotateHandler(event:PropertyEditorEvent):void
        {
            this.dispatch(new SceneEvent(SceneEvent.ROTATE_OBJECT,[view.data], event.data, true));
        }
        private function view_scaleHandler(event:PropertyEditorEvent):void
        {
            this.dispatch(new SceneEvent(SceneEvent.SCALE_OBJECT,[view.data], event.data, true));
        }
        private function view_meshChangeHandler(event:PropertyEditorEvent):void
        {
            this.dispatch(new SceneEvent(SceneEvent.CHANGE_MESH,[view.data], event.data));
        }
        private function view_meshNameChangeHandler(event:PropertyEditorEvent):void
        {
            this.dispatch(new SceneEvent(SceneEvent.CHANGE_MESH,[view.data], event.data, true));
        }
        private function view_meshSubmeshChangeHandler(event:PropertyEditorEvent):void
        {
            var vo:MeshVO = view.data as MeshVO;
            var newValue:MeshVO = vo.clone() as MeshVO;
            for each( var subMesh:SubMeshVO in newValue.subMeshes )
            {
                if( subMesh.equals( AssetVO(event.data) ) )
                {
                    subMesh.material = SubMeshVO(event.data).material;
                }
            }
            this.dispatch(new SceneEvent(SceneEvent.CHANGE_MESH,[view.data], newValue));
        }
        private function view_materialChangeHandler(event:PropertyEditorEvent):void
        {
            this.dispatch(new SceneEvent(SceneEvent.CHANGE_MATERIAL,[view.data], event.data));
        }
        private function view_materialNameChangeHandler(event:PropertyEditorEvent):void
        {
            this.dispatch(new SceneEvent(SceneEvent.CHANGE_MATERIAL,[view.data], event.data, true));
        }
		
		private function view_shadowmethodChangeHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.CHANGE_SHADOW_METHOD,[view.data], event.data));
		}
		private function view_shadowmethodChangeStepperHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.CHANGE_SHADOW_METHOD,[view.data], event.data, true));
		}
		
		private function view_showChildObjectPropertiesHandler(event:PropertyEditorEvent):void
		{
			view.prevSelected.addItem(view.data);
			this.dispatch(new SceneEvent(SceneEvent.SELECT,[event.data],true));
		}
		
		private function view_showParentMeshHandler(event:PropertyEditorEvent):void
		{
			
			this.dispatch(new SceneEvent(SceneEvent.SELECT,[event.data],false,false,true));
			
		}
		private function view_showParentMaterialHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.SELECT,[event.data],false,false,true));
		}
		
		
//		private function view_materialAddShadowMethodHandler(event:PropertyEditorEvent):void
//		{
//			var availableLight:LightVO;
//			for each( var asset:AssetVO in document.lights ) 
//			{
//				var light:LightVO = asset as LightVO;
//				
//				if( light && light.castsShadows ) 
//				{
//					availableLight = light;
//					break;
//				}
//			}
//			if( !availableLight )
//			{
//				Alert.show( "You have to create Light that casts shadow", "Operation Terminated");
//				return;
//			}
//			
//			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_SHADOW_METHOD,[view.data], AssetFactory.CreateSahdowMapMethod( availableLight )));
//		}
		
		private function view_shadowmethodAddLightHandler(event:PropertyEditorEvent):void
		{
//			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_LIGHT,[view.data]));
		}
		
		private function view_materialAddLightpickerHandler(event:PropertyEditorEvent):void
		{
			var asset:LightPickerVO = AssetFactory.CreateLightPicker();
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_LIGHTPICKER,[view.data], asset ));
		}
		
		private function view_materialAddNewTextureHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new ImportTextureEvent(ImportTextureEvent.IMPORT_AND_ADD,[view.data],event.data));
		}
		private function view_materialAddEffectMetodHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_EFFECT_METHOD,[view.data], AssetFactory.CreateEffectMethod( event.data as String )));
			
		}
		private function view_materialRemoveEffectMetodHandler(event:PropertyEditorEvent):void
		{
			var material:MaterialVO = MaterialVO(view.data);
			for (var i:int = 0; i < material.effectMethods.length; i++) 
			{
				if( material.effectMethods.getItemAt( i ) == event.data )
				{
					material.effectMethods.removeItemAt(i);
					i--;
				}
			}
			
			this.dispatch(new SceneEvent(SceneEvent.CHANGE_MATERIAL,[view.data], material));
		}
		
		
		private function view_submeshAddNewMaterialHandler(event:PropertyEditorEvent):void
		{
			var newValue:SubMeshVO = SubMeshVO(event.data);
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_MATERIAL,[newValue], AssetFactory.CreateMaterialCopy( newValue.material )));
		}
		private function view_replaceTextureHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new ImportTextureEvent(ImportTextureEvent.IMPORT_AND_REPLACE,[event.data]));
		}
		
		private function view_lightPositionChangeHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.TRANSLATE_OBJECT,[view.data], event.data, true));
		}
		
		private function view_lightChangeHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.CHANGE_LIGHT,[view.data], event.data));
		}
		private function view_lightAddFilteredShadowMapMethodHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_SHADOW_METHOD,[view.data], AssetFactory.CreateFilteredShadowMapMethod(view.data as LightVO)));
		}
		private function view_lightAddCascadeShadowMapMethodHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_SHADOW_METHOD,[view.data], AssetFactory.CreateCascadeShadowMapMethod(view.data as LightVO)));
		}
		private function view_lightAddDitheredShadowMapHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_SHADOW_METHOD,[view.data], AssetFactory.CreateDitheredShadowMapMethod(view.data as LightVO)));
		}
		private function view_lightAddHardShadowMapMethodHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_SHADOW_METHOD,[view.data], AssetFactory.CreateHardShadowMapMethod(view.data as LightVO)));
		}
		private function view_lightAddNearShadowMapMethodHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_SHADOW_METHOD,[view.data], AssetFactory.CreateNearShadowMapMethod(view.data as LightVO)));
		}
		private function view_lightAddSoftShadowMapMethodHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_SHADOW_METHOD,[view.data], AssetFactory.CreateSoftShadowMapMethod(view.data as LightVO)));
		}
		
		
		private function view_lightStepperChangeHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.CHANGE_LIGHT, [view.data], event.data, true));
		}
		
		private function view_lightPickerChangeHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.CHANGE_LIGHTPICKER,[view.data], event.data));
		}
		private function view_lightPickerStepperChangeHandler(event:PropertyEditorEvent):void
		{
			this.dispatch(new SceneEvent(SceneEvent.CHANGE_LIGHTPICKER, [view.data], event.data, true));
		}
		private function view_lightPickerAddLightHandler(event:PropertyEditorEvent):void
		{
			var asset:LightVO = AssetFactory.CreateLight();
			this.dispatch(new SceneEvent(SceneEvent.ADD_NEW_LIGHT,[view.data],asset));
		}
		
		
        //----------------------------------------------------------------------
        //
        //	context handlers
        //
        //----------------------------------------------------------------------

		
		private function eventDispatcher_translateHandler(event:SceneEvent):void
		{
			view.SetData( event.items[0] );
		}
		
		private function eventDispatcher_changeLightHandler(event:SceneEvent):void
		{
			view.SetData( event.items[0] );
		}
		private function eventDispatcher_changeLightPickerHandler(event:SceneEvent):void
		{
			view.SetData( event.items[0] );
		}
		
        private function eventDispatcher_changeMeshHandler(event:SceneEvent):void
        {
            var mesh:MeshVO = MeshVO( event.items[0] ) as MeshVO;

            for each( var subMesh:SubMeshVO in  mesh.subMeshes )
            {
                subMesh.linkedMaterials = document.materials;
            }

            view.SetData( mesh );
        }
		
		private function eventDispatcher_addNewLightpickerToMaterialHandler(event:SceneEvent):void
		{
			if( event.items && event.items.length )
			{
				view.SetData(event.items[0]);
			}
		}
		private function eventDispatcher_addNewLightToLightpickerHandler(event:SceneEvent):void
		{
			if( event.items && event.items.length )
			{
				view.SetData(event.items[0]);
			}
		}
		
		private function eventDispatcher_addNewMethodHandler(event:SceneEvent):void
		{
			if( event.items && event.items.length )
			{
				view.SetData(event.items[0]);
			}
		}
		private function eventDispatcher_addNewMaterialToSubmeshHandler(event:SceneEvent):void
		{
			var subMesh:SubMeshVO = SubMeshVO( event.items[0] );
			var mesh:MeshVO = subMesh.parentMesh as MeshVO;
			for each( var o:SubMeshVO in mesh.subMeshes )
			{
				o.linkedMaterials = document.materials;
			}
			
			view.SetData(mesh);
		}
		
		
		private function eventDispatcher_addNewTextureHandler(event:SceneEvent):void
		{
			if( event.items && event.items.length )
			{
				view.SetData(event.items[0]);
			}
		}
        private function eventDispatcher_changeMaterialHandler(event:SceneEvent):void
        {
			view.SetData(event.items[0]);
        }
        private function eventDispatcher_changingHandler(event:SceneEvent):void
        {
			view.SetData( event.items[0] );
        }
        private function eventDispatcher_itemsSelectHandler(event:SceneEvent):void
        {
			
            if( !event.items || event.items.length == 0)
            {
				view.showEditor( "empty", event.newValue, event.oldValue );
				view.collapsed = true;
                return;
            }
            if( event.items.length )
            {
                if( event.items.length == 1 )
                {
                    if( event.items[0] is MeshVO )
                    {
						var t:Number = getTimer();
                        var mesh:MeshVO = MeshVO( event.items[0] ) as MeshVO;
                        for each( var subMesh:SubMeshVO in  mesh.subMeshes )
                        {
                            subMesh.linkedMaterials = document.materials;
                        }
						view.SetData(mesh);
						view.showEditor( "mesh", event.newValue, event.oldValue );
                    }
                    else if( event.items[0] is ContainerVO )
                    {
						view.showEditor( "container", event.newValue, event.oldValue );
						view.SetData(event.items[0]);
                    }
                    else if( event.items[0] is MaterialVO )
                    {
						view.SetData(event.items[0]);
						view.showEditor( "material", event.newValue, event.oldValue );
						
                    }
                    else if( event.items[0] is TextureVO )
                    {
						view.showEditor( "texture", event.newValue, event.oldValue );
						view.SetData(event.items[0]);
                    }
					else if( event.items[0] is LightVO )
					{
						view.showEditor( "light", event.newValue, event.oldValue );
						view.SetData(event.items[0]);
					}
					else if( event.items[0] is LightPickerVO )
					{
						view.showEditor( "lightPicker", event.newValue, event.oldValue );
						view.SetData(event.items[0]);
					}
					else if( event.items[0] is ShadowMethodVO )
					{
						view.showEditor( "shadowMethod", event.newValue, event.oldValue );
						view.SetData(event.items[0]);
					}
					else if( event.items[0] is EffectMethodVO )
					{
						view.showEditor( "effectMethod", event.newValue, event.oldValue );
						view.SetData(event.items[0]);
					}
//                    else if( event.items[0] is Geometry )
//                    {
//                        view.currentState = "geometry";
//                    }
                    else
                    {
						view.showEditor( "empty", event.newValue, event.oldValue );
                    }
                }
                else
                {
					view.showEditor( "group", event.newValue, event.oldValue );
                }
				view.validateNow();
            }
            else
            {
				view.showEditor( "empty", event.newValue, event.oldValue );
            }
			//if event.oldValue is true it means that we just back from child
			//if event.newValue is true it means that we select child
			if( !(event.oldValue||event.newValue) && view.prevSelected.length ) {
				view.prevSelected = new ArrayCollection();
			}
        }

		private function context_documentUpdatedHandler(event:DocumentModelEvent):void
		{
			var nullItem:AssetVO = new AssetVO();
			nullItem.name = "Null";
			nullItem.isNull = true;
			var nullTextureItem:TextureVO = new TextureVO();
			nullTextureItem.name = "Null";
			nullTextureItem.isNull = true;
			var asset:AssetVO;
			var lights:ArrayCollection = new ArrayCollection();
			var pickers:ArrayCollection = new ArrayCollection();
			pickers.addItem( nullItem );
			for each( asset in document.lights )
			{
				if( asset is LightPickerVO ) pickers.addItem( asset );
				if( asset is LightVO ) 
				{
					if( LightVO(asset).castsShadows ) lights.addItem( asset );
				}
			}
			view.lightPickers = pickers;
			view.lights = lights;
			
			var shadowMethods:ArrayCollection = new ArrayCollection();
			shadowMethods.addItem( nullItem );
			var ambientMethods:ArrayCollection = new ArrayCollection();
			var normalMethods:ArrayCollection = new ArrayCollection();
			var diffuseMethods:ArrayCollection = new ArrayCollection();
			var specularMethods:ArrayCollection = new ArrayCollection();
			for each( asset in document.methods )
			{
				if( asset is ShadowMethodVO ) shadowMethods.addItem( asset );
			}
			view.shadowMethods = shadowMethods;
			view.normalMethods = normalMethods;
			view.ambientMethods = ambientMethods;
			view.diffuseMethods = diffuseMethods;
			view.specularMethods = specularMethods;
			
			var textures:ArrayCollection = new ArrayCollection();
			textures.addItem( nullTextureItem );
			for each( asset in document.textures )
			{
				textures.addItem( asset );
			}
			view.textures = textures;
		}
    }
}
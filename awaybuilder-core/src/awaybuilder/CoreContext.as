package awaybuilder
{
	import awaybuilder.controller.ReadDocumentDataFaultCommand;
	import awaybuilder.controller.ResetDefaultSettingsCommand;
	import awaybuilder.controller.StartupCommand;
	import awaybuilder.controller.clipboard.CopyCommand;
	import awaybuilder.controller.clipboard.PasteCommand;
	import awaybuilder.controller.clipboard.events.ClipboardEvent;
	import awaybuilder.controller.clipboard.events.PasteEvent;
	import awaybuilder.controller.document.AppendDocumentCommand;
	import awaybuilder.controller.document.ConcatenateDocumentDataCommand;
	import awaybuilder.controller.document.ImportDocumentCommand;
	import awaybuilder.controller.document.ImportTextureAndReplaceCommand;
	import awaybuilder.controller.document.ImportTextureForMaterialCommand;
	import awaybuilder.controller.document.LoadTextureAndRepalceCommand;
	import awaybuilder.controller.document.LoadTextureForMaterialCommand;
	import awaybuilder.controller.document.NewDocumentCommand;
	import awaybuilder.controller.document.OpenDocumentCommand;
	import awaybuilder.controller.document.ReplaceDocumentCommand;
	import awaybuilder.controller.document.SaveDocumentCommand;
	import awaybuilder.controller.document.SaveDocumentFailCommand;
	import awaybuilder.controller.document.SaveDocumentSuccessCommand;
	import awaybuilder.controller.document.events.ImportTextureEvent;
	import awaybuilder.controller.events.DocumentDataOperationEvent;
	import awaybuilder.controller.events.DocumentEvent;
	import awaybuilder.controller.events.ReadDocumentDataResultEvent;
	import awaybuilder.controller.events.ReadDocumentEvent;
	import awaybuilder.controller.events.SaveDocumentEvent;
	import awaybuilder.controller.events.SettingsEvent;
	import awaybuilder.controller.history.RedoCommand;
	import awaybuilder.controller.history.UndoCommand;
	import awaybuilder.controller.history.UndoRedoEvent;
	import awaybuilder.controller.scene.AddNewEffectMethodCommand;
	import awaybuilder.controller.scene.AddNewLightCommand;
	import awaybuilder.controller.scene.AddNewLightPickerCommand;
	import awaybuilder.controller.scene.AddNewMaterialCommand;
	import awaybuilder.controller.scene.AddNewShadowMethodCommand;
	import awaybuilder.controller.scene.AddNewTextureCommand;
	import awaybuilder.controller.scene.ChangeLightCommand;
	import awaybuilder.controller.scene.ChangeLightPickerCommand;
	import awaybuilder.controller.scene.ChangeMaterialCommand;
	import awaybuilder.controller.scene.ChangeMeshCommand;
	import awaybuilder.controller.scene.DeleteObjectCommand;
	import awaybuilder.controller.scene.ReplaceTextureCommand;
	import awaybuilder.controller.scene.RotateObjectCommand;
	import awaybuilder.controller.scene.ScaleObjectCommand;
	import awaybuilder.controller.scene.SelectCommand;
	import awaybuilder.controller.scene.SwitchFreeCameraModeCommand;
	import awaybuilder.controller.scene.SwitchTargetCameraModeCommand;
	import awaybuilder.controller.scene.SwitchTransformRotateModeCommand;
	import awaybuilder.controller.scene.SwitchTransformScaleModeCommand;
	import awaybuilder.controller.scene.SwitchTransformTranslateModeCommand;
	import awaybuilder.controller.scene.TranslateObjectCommand;
	import awaybuilder.controller.scene.events.SceneEvent;
	import awaybuilder.model.DocumentModel;
	import awaybuilder.model.IDocumentModel;
	import awaybuilder.model.ISettingsModel;
	import awaybuilder.model.ProcessDataService;
	import awaybuilder.model.SamplesModel;
	import awaybuilder.model.SettingsModel;
	import awaybuilder.model.UndoRedoModel;
	import awaybuilder.model.WindowModel;
	import awaybuilder.view.components.ApplicationSettingsForm;
	import awaybuilder.view.components.CoreEditor;
	import awaybuilder.view.components.DocumentDefaultsSettingsForm;
	import awaybuilder.view.components.DocumentSettingsForm;
	import awaybuilder.view.components.EditStatusBar;
	import awaybuilder.view.components.EditToolBar;
	import awaybuilder.view.components.EditingSurfaceSettingsForm;
	import awaybuilder.view.components.LibraryPanel;
	import awaybuilder.view.components.PropertiesPanel;
	import awaybuilder.view.components.SamplePicker;
	import awaybuilder.view.mediators.ApplicationSettingsFormMediator;
	import awaybuilder.view.mediators.CoreEditorMediator;
	import awaybuilder.view.mediators.DocumentDefaultsSettingsFormMediator;
	import awaybuilder.view.mediators.DocumentSettingsFormMediator;
	import awaybuilder.view.mediators.EditStatusBarMediator;
	import awaybuilder.view.mediators.EditToolBarMediator;
	import awaybuilder.view.mediators.EditingSurfaceSettingsFormMediator;
	import awaybuilder.view.mediators.LibraryPanelMediator;
	import awaybuilder.view.mediators.PropertiesPanelMediator;
	import awaybuilder.view.mediators.SamplePickerMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	public class CoreContext extends Context
	{
		public function CoreContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup():void
		{
			super.startup();
			
			this.commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand);

			this.commandMap.mapEvent(DocumentEvent.NEW_DOCUMENT, NewDocumentCommand);
			this.commandMap.mapEvent(DocumentEvent.OPEN_DOCUMENT, OpenDocumentCommand);
			this.commandMap.mapEvent(DocumentEvent.IMPORT_DOCUMENT, ImportDocumentCommand);
			
			this.commandMap.mapEvent(ReadDocumentEvent.REPLACE_DOCUMENT, ReplaceDocumentCommand);
			this.commandMap.mapEvent(ReadDocumentEvent.APPEND_DOCUMENT, AppendDocumentCommand);
			
			this.commandMap.mapEvent(DocumentDataOperationEvent.CONCAT_DOCUMENT_DATA, ConcatenateDocumentDataCommand);
			
			this.commandMap.mapEvent(ReadDocumentDataResultEvent.READ_DOCUMENT_DATA_FAULT, ReadDocumentDataFaultCommand);
			
			this.commandMap.mapEvent(SaveDocumentEvent.SAVE_DOCUMENT, SaveDocumentCommand);
			this.commandMap.mapEvent(SaveDocumentEvent.SAVE_DOCUMENT_AS, SaveDocumentCommand);
			this.commandMap.mapEvent(SaveDocumentEvent.SAVE_DOCUMENT_SUCCESS, SaveDocumentSuccessCommand);
			this.commandMap.mapEvent(SaveDocumentEvent.SAVE_DOCUMENT_FAIL, SaveDocumentFailCommand);
			
			this.commandMap.mapEvent(SceneEvent.SWITCH_CAMERA_TO_FREE, SwitchFreeCameraModeCommand);
			this.commandMap.mapEvent(SceneEvent.SWITCH_CAMERA_TO_TARGET, SwitchTargetCameraModeCommand);
			
			this.commandMap.mapEvent(SceneEvent.SWITCH_TRANSFORM_ROTATE, SwitchTransformRotateModeCommand);
			this.commandMap.mapEvent(SceneEvent.SWITCH_TRANSFORM_SCALE, SwitchTransformScaleModeCommand);
			this.commandMap.mapEvent(SceneEvent.SWITCH_TRANSFORM_TRANSLATE, SwitchTransformTranslateModeCommand);

            this.commandMap.mapEvent(SceneEvent.ROTATE_OBJECT, RotateObjectCommand);
            this.commandMap.mapEvent(SceneEvent.TRANSLATE_OBJECT, TranslateObjectCommand);
            this.commandMap.mapEvent(SceneEvent.SCALE_OBJECT, ScaleObjectCommand);
			
			this.commandMap.mapEvent(SceneEvent.DELETE_OBJECTS, DeleteObjectCommand);
			this.commandMap.mapEvent(SceneEvent.SELECT, SelectCommand);
			
			this.commandMap.mapEvent(ImportTextureEvent.IMPORT_AND_ADD, ImportTextureForMaterialCommand);
			this.commandMap.mapEvent(ImportTextureEvent.LOAD_AND_ADD, LoadTextureForMaterialCommand);
			
			this.commandMap.mapEvent(ImportTextureEvent.IMPORT_AND_REPLACE, ImportTextureAndReplaceCommand);
			this.commandMap.mapEvent(ImportTextureEvent.LOAD_AND_REPLACE, LoadTextureAndRepalceCommand);
			
            commandMap.mapEvent(SceneEvent.CHANGE_MESH, ChangeMeshCommand);
            commandMap.mapEvent(SceneEvent.CHANGE_MATERIAL, ChangeMaterialCommand);
			commandMap.mapEvent(SceneEvent.CHANGE_LIGHT, ChangeLightCommand);
			commandMap.mapEvent(SceneEvent.CHANGE_LIGHTPICKER, ChangeLightPickerCommand);
			
			commandMap.mapEvent(SceneEvent.ADD_NEW_MATERIAL, AddNewMaterialCommand);
			commandMap.mapEvent(SceneEvent.ADD_NEW_TEXTURE, AddNewTextureCommand);
			commandMap.mapEvent(SceneEvent.ADD_NEW_LIGHT, AddNewLightCommand);
			commandMap.mapEvent(SceneEvent.ADD_NEW_LIGHTPICKER, AddNewLightPickerCommand);
			commandMap.mapEvent(SceneEvent.ADD_NEW_SHADOW_METHOD, AddNewShadowMethodCommand);
			commandMap.mapEvent(SceneEvent.ADD_NEW_EFFECT_METHOD, AddNewEffectMethodCommand);
			
			commandMap.mapEvent(SceneEvent.REPLACE_TEXTURE, ReplaceTextureCommand);

			this.commandMap.mapEvent(ClipboardEvent.CLIPBOARD_CUT, CopyCommand);
			this.commandMap.mapEvent(ClipboardEvent.CLIPBOARD_COPY, CopyCommand);
			this.commandMap.mapEvent(PasteEvent.CLIPBOARD_PASTE, PasteCommand);
			
			this.commandMap.mapEvent(SettingsEvent.RESET_DEFAULT_SETTINGS, ResetDefaultSettingsCommand);
			
            commandMap.mapEvent( UndoRedoEvent.REDO, RedoCommand );
            commandMap.mapEvent( UndoRedoEvent.UNDO, UndoCommand );

			this.injector.mapSingletonOf(IDocumentModel, DocumentModel);
			this.injector.mapSingletonOf(ISettingsModel, SettingsModel);
			this.injector.mapSingleton(UndoRedoModel);
			this.injector.mapSingleton(ProcessDataService);
			this.injector.mapSingleton(WindowModel);
			this.injector.mapSingleton(SamplesModel);
			this.injector.mapValue(SettingsModel, this.injector.getInstance(ISettingsModel));
			
			this.mediatorMap.mapView(CoreEditor, CoreEditorMediator);
            this.mediatorMap.mapView(PropertiesPanel, PropertiesPanelMediator);
			this.mediatorMap.mapView(LibraryPanel, LibraryPanelMediator);
			this.mediatorMap.mapView(EditToolBar, EditToolBarMediator);
			this.mediatorMap.mapView(EditStatusBar, EditStatusBarMediator);
			this.mediatorMap.mapView(ApplicationSettingsForm, ApplicationSettingsFormMediator);
			this.mediatorMap.mapView(DocumentSettingsForm, DocumentSettingsFormMediator);
			this.mediatorMap.mapView(EditingSurfaceSettingsForm, EditingSurfaceSettingsFormMediator);
			this.mediatorMap.mapView(DocumentDefaultsSettingsForm, DocumentDefaultsSettingsFormMediator);
			this.mediatorMap.mapView(SamplePicker, SamplePickerMediator);
//			this.mediatorMap.mapView(SampleItemRenderer, SampleItemRendererMediator);
//			this.mediatorMap.mapView(ShapePropertyEditor, RectanglePropertyEditorMediator);
		}
	}
}
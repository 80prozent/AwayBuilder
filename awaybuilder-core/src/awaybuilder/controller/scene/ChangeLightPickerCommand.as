package awaybuilder.controller.scene
{
	import awaybuilder.controller.history.HistoryCommandBase;
	import awaybuilder.controller.scene.events.SceneEvent;
	import awaybuilder.model.IDocumentModel;
	import awaybuilder.model.vo.scene.LightPickerVO;
	import awaybuilder.utils.DataMerger;

	public class ChangeLightPickerCommand extends HistoryCommandBase
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var document:IDocumentModel;
		
		override public function execute():void
		{
			
			var newAsset:LightPickerVO = event.newValue as LightPickerVO;
			
			var vo:LightPickerVO = event.items[0] as LightPickerVO;

			saveOldValue( event, vo.clone() );
			
			vo.name = newAsset.name;
			
			DataMerger.syncArrays( vo.lights, newAsset.lights, "id" );
			
			addToHistory( event );
		}
	}
}
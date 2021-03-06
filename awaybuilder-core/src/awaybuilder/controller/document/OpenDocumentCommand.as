package awaybuilder.controller.document
{
	import awaybuilder.controller.events.ReadDocumentEvent;
	import awaybuilder.model.IDocumentService;
	
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenDocumentCommand extends Command
	{
		[Inject]
		public var fileService:IDocumentService;
		
		override public function execute():void
		{
			var nextEvent:ReadDocumentEvent = new ReadDocumentEvent(ReadDocumentEvent.REPLACE_DOCUMENT, null, null);
			this.fileService.open( "open", nextEvent );
		}
	}
}
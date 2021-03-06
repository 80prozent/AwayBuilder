package awaybuilder.controller.scene
{
    import away3d.core.base.SubMesh;
    import away3d.entities.Mesh;
    import away3d.library.AssetLibrary;
    import away3d.materials.MaterialBase;
    
    import awaybuilder.controller.history.HistoryCommandBase;
    import awaybuilder.controller.scene.events.SceneEvent;
    import awaybuilder.model.IDocumentModel;
    import awaybuilder.model.vo.scene.MaterialVO;
    import awaybuilder.model.vo.scene.MeshVO;
    import awaybuilder.model.vo.scene.SubMeshVO;
    import awaybuilder.utils.AssetFactory;

    public class ChangeMeshCommand extends HistoryCommandBase
    {
        [Inject]
        public var event:SceneEvent;

        [Inject]
        public var document:IDocumentModel;

        override public function execute():void
        {
            var mesh:MeshVO = event.newValue as MeshVO;
            var vo:MeshVO = event.items[0] as MeshVO;
			
			if( !event.oldValue ) {
				event.oldValue = vo.clone();
			}
			
            vo.name = mesh.name;

            var subMeshes:Vector.<SubMesh> = new Vector.<SubMesh>();
            var newSubMeshes:Array = new Array();

            for( var i:int = 0; i < mesh.subMeshes.length; i++ )
            {
                var updatedSubMesh:SubMeshVO = mesh.subMeshes[i] as SubMeshVO;
                var subMesh:SubMeshVO = vo.subMeshes[i] as SubMeshVO;
                subMesh.material = updatedSubMesh.material;
            }

            addToHistory( event );
        }
    }
}
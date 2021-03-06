package awaybuilder.model
{
	import awaybuilder.controller.events.DocumentModelEvent;
	import awaybuilder.model.vo.scene.AssetVO;
	import awaybuilder.model.vo.scene.ContainerVO;
	import awaybuilder.model.vo.scene.DocumentVO;
	
	import flash.display3D.textures.Texture;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;
	
	import org.robotlegs.mvcs.Actor;

	public class DocumentModel extends Actor implements IDocumentModel
	{
		public var documentVO:DocumentVO = new DocumentVO();
		
		private var _empty:Boolean = true;
		public function get empty():Boolean
		{
			return this._empty;
		}
		public function set empty(value:Boolean):void
		{
			this._empty = value;
		}
		
		private var _name:String;
		public function get name():String
		{
			return this._name;
		}
		public function set name(value:String):void
		{
			if(this._name == value)
			{
				return;
			}
			this._name = value;
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.DOCUMENT_NAME_CHANGED));
		}
		
		private var _edited:Boolean = false;
		public function get edited():Boolean
		{
			return this._edited;
		}
		public function set edited(value:Boolean):void
		{
			if(this._edited == value)
			{
				return;
			}
			this._edited = value;
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.DOCUMENT_EDITED));
		}
		
		private var _savedNativePath:String;
		public function get path():String
		{
			return this._savedNativePath;
		}
		public function set path(value:String):void
		{
			this._savedNativePath = value;
		}
		
		private var _selectedObjects:Vector.<AssetVO> = new Vector.<AssetVO>();
		public function get selectedObjects():Vector.<AssetVO>
		{
			return this._selectedObjects;
		}
		public function set selectedObjects(value:Vector.<AssetVO>):void
		{
			this._selectedObjects = value;
		}
		
		public function get animations():ArrayCollection
		{
			return documentVO.animations;
		}
		public function set animations(value:ArrayCollection):void
		{
			documentVO.animations = value;
		}
		
		public function get geometry():ArrayCollection
		{
			return documentVO.geometry;
		}
		public function set geometry(value:ArrayCollection):void
		{
			documentVO.geometry = value;
		}
		
		public function get materials():ArrayCollection
		{
			return documentVO.materials;
		}
		public function set materials(value:ArrayCollection):void
		{
			documentVO.materials = value;
		}
		
		public function get scene():ArrayCollection
		{
			return documentVO.scene;
		}
		public function set scene(value:ArrayCollection):void
		{
			documentVO.scene = value;
		}
		
		public function get skeletons():ArrayCollection
		{
			return documentVO.skeletons;
		}
		public function set skeletons(value:ArrayCollection):void
		{
			documentVO.skeletons = value;
		}
		
		public function get textures():ArrayCollection
		{
			return documentVO.textures;
		}
		public function set textures(value:ArrayCollection):void
		{
			documentVO.textures = value;
		}
		
		public function get lights():ArrayCollection
		{
			return documentVO.lights;
		}
		public function set lights(value:ArrayCollection):void
		{
			documentVO.lights = value;
		}
		
		public function get methods():ArrayCollection
		{
			return documentVO.methods;
		}
		public function set methods(value:ArrayCollection):void
		{
			documentVO.methods = value;
		}
		
		
		private var _copiedObjects:Vector.<AssetVO>;
		public function get copiedObjects():Vector.<AssetVO>
		{
			return _copiedObjects;
		}
		public function set copiedObjects(value:Vector.<AssetVO>):void
		{
			_copiedObjects = value;
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.CLIPBOARD_UPDATED));
		}
		
//		public function getAnimation(value:Object):AssetVO
//		{
//			return getItemInCollection( animations, value );
//		}
//		
//		public function getGeometry(value:Object):AssetVO
//		{
//			return getItemInCollection( geometry, value );
//		}
//		
//		public function getLight(value:Object):AssetVO
//		{
//			return getItemInCollection( lights, value );
//		}
//		
//		public function getMaterial(value:Object):AssetVO
//		{
//			return getItemInCollection( materials, value );
//		}
//		
//		public function getSceneObject(value:Object):ContainerVO
//		{
//			return getContainerInCollection( scene, value );
//		}
//		
//		public function getSkeleton(value:Object):AssetVO
//		{
//			return getItemInCollection( skeletons, value );
//		}
//		
//		public function getTexture(value:Object):AssetVO
//		{
//			return getItemInCollection( textures, value );
//		}
		
		public function clear():void
		{
			documentVO = new DocumentVO();
			_selectedObjects = new Vector.<AssetVO>();
			empty = true;
		}
		
		public function removeAssets( source:ArrayCollection, items:ArrayCollection ):void
		{
			for each( var oddItem:AssetVO in items ) 
			{
				removeAsset( source, oddItem );
			}
		}
		public function removeAsset( source:ArrayCollection, oddItem:AssetVO ):void
		{
			for (var i:int = 0; i < source.length; i++) 
			{
				if( source[i].id == oddItem.id )
				{
					source.removeItemAt( i );
					i--;
				}
			}
		}
		
		// private 
		
//		private function getItemInCollection( children:ArrayCollection, value:Object ):AssetVO
//		{
//			for each( var vo:AssetVO in children )
//			{
//				if( vo.id == value ) 
//				{
//					return vo;
//				}
//			}
//			return null;
//		}
//		private function getContainerInCollection( children:ArrayCollection, value:Object ):ContainerVO
//		{
//			for each( var vo:ContainerVO in children )
//			{
//				if( vo.id == value ) 
//				{
//					return vo;
//				}
//			}
//			return null;
//		}
	}
}
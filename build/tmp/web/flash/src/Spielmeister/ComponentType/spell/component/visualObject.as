package Spielmeister.ComponentType.spell.component {

	public class visualObject {
		private var _layer : Number
		private var _pass : String
		private var _opacity : Number
		private var _worldOpacity : Number

		public function visualObject( spell : Object ) {
			this._layer = 1;
			this._pass = "world";
			this._opacity = 1;
			this._worldOpacity = 1;
		}

		public function get layer() : Number {
			return this._layer;
		}

		public function set layer( x : Number ) {
			this._layer = x;
		}

		public function get pass() : String {
			return this._pass;
		}

		public function set pass( x : String ) {
			this._pass = x;
		}

		public function get opacity() : Number {
			return this._opacity;
		}

		public function set opacity( x : Number ) {
			this._opacity = x;
		}

		public function get worldOpacity() : Number {
			return this._worldOpacity;
		}

		public function set worldOpacity( x : Number ) {
			this._worldOpacity = x;
		}
	}
}

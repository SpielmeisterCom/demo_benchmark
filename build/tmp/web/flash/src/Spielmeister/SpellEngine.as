package Spielmeister {
	import flash.debugger.enterDebugger
	public class SpellEngine implements ModuleDefinition {
		public function SpellEngine() {}

		public function load( define : Function, require : Function ) : void {
			define("31xs7IP9/9HMl0FlArPRi/p/6e1y56BYxsmywdBgw2Y=", [ "J19VukA9OHTe67LZyXj0g0dFAjqaCGG1/kxNYjbMFWo=" ], function(e) {
			    "use strict";
			    return e;
			}), define("ejgJf7mQ9axq1cyy26lksn3189ZkhWjFWj4zgUj60cw=", [ "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t) {
			    "use strict";
			    var n = e.Box2D, r = n.Common.Math.createB2Vec2, i = n.Dynamics.createB2World, s = n.Dynamics.b2Body, o = n.Dynamics.createB2BodyDef, u = n.Dynamics.createB2FilterData, a = {}, f = function(e) {
			        return a[e];
			    }, l = function(e, t, n) {
			        var i = this.getBodyById(e);
			        if (!i) return;
			        var s = this.scale, o = t[0] * s, u = t[1] * s;
			        (o || u) && i.ApplyForce(r(o, u), n ? r(n[0] * s, n[1] * s) : i.GetWorldCenter());
			    }, c = function(e, t) {
			        var n = this.getBodyById(e);
			        if (!n) return;
			        t && n.ApplyTorque(t * this.scale);
			    }, h = function(e, t, n) {
			        var i = this.getBodyById(e);
			        if (!i) return;
			        var s = this.scale, o = t[0] * s, u = t[1] * s;
			        (o || u) && i.ApplyImpulse(r(o, u), n ? r(n[0] * s, n[1] * s) : i.GetWorldCenter());
			    }, p = function(e, t) {
			        var n = this.getBodyById(e);
			        if (!n) return;
			        var i = this.scale;
			        n.SetLinearVelocity(r(t[0] * i, t[1] * i));
			    }, d = function(e, t, n) {
			        var r = this.getBodyById(e);
			        if (!r) return;
			        for (var i = r.GetFixtureList(); i; i = i.GetNext()) {
			            var s = i.GetFilterData(), o = u();
			            o.categoryBits = t === undefined ? s.categoryBits : t, o.maskBits = n === undefined ? s.maskBits : n, i.SetFilterData(o);
			        }
			    }, v = function(e, t) {
			        var n = this.getBodyById(e);
			        if (!n) return;
			        n.SetAwake(t);
			    }, m = function(e, t) {
			        var n = this.getBodyById(e);
			        if (!n) return;
			        var i = this.scale;
			        n.SetPosition(r(t[0] * i, t[1] * i));
			    }, g = function(e) {
			        return e === "static" ? s.b2_staticBody : e === "dynamic" ? s.b2_dynamicBody : e === "kinematic" ? s.b2_kinematicBody : undefined;
			    }, y = function(e) {
			        return e === "static";
			    }, b = function(e, t, n) {
			        var r = n.translation, i = o(), s = g(t.type), u = this.scale;
			        if (s === undefined) return;
			        i.awake = !y(t.type), i.fixedRotation = t.fixedRotation, i.type = s, i.position.x = r[0] * u, i.position.y = r[1] * u, i.angle = n.rotation, i.userData = e;
			        var t = this.rawWorld.CreateBody(i);
			        return a[e] = t, t;
			    }, w = function(e) {
			        var t = this.getBodyById(e);
			        if (!t) return;
			        delete a[e], this.rawWorld.DestroyBody(t);
			    }, E = function() {
			        return this.rawWorld;
			    }, S = function(e, t, n) {
			        e === undefined && (e = !0), t || (t = [ 0, 0 ]), n || (n = 1), this.rawWorld = i(r(t[0], t[1]), e), this.scale = n;
			    };
			    return S.prototype = {
			        applyForce: l,
			        applyImpulse: h,
			        applyTorque: c,
			        createBodyDef: b,
			        destroyBody: w,
			        getBodyById: f,
			        getRawWorld: E,
			        setAwake: v,
			        setFilterData: d,
			        setPosition: m,
			        setVelocity: p
			    }, function(e, t, n) {
			        return new S(e, t, n);
			    };
			}), define("Y+HrMll7Ng4+i8ynbZkdI2CDky7Ts7kFhGQCNWGqGQw=", [ "ejgJf7mQ9axq1cyy26lksn3189ZkhWjFWj4zgUj60cw=" ], function(e) {
			    "use strict";
			    return function() {
			        return {
			            createWorld: e
			        };
			    };
			}), define("39gFs/6MB0ozYMGq2AC/r1nziKIaUeLJSZaG9oJ55h8=", [ "wspZzshkZyWF8MhE/MwHByCOFh6eOue2ZqHunVz8+I8=" ], function(e) {
			    "use strict";
			    return e;
			}), define("x81J/Fr9o8YgVYUYkA4GBLPAGmW4ok/0zW45f+sTXe4=", [ "39gFs/6MB0ozYMGq2AC/r1nziKIaUeLJSZaG9oJ55h8=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t) {
			    "use strict";
			    var n = 0, r = 1, i = 2, s = 3, o = 4, u = [ "DEBUG", "INFO", "WARN", "ERROR", "SILENT" ], a = function(e) {
			        if (e < 0 || e > 4) throw "Log level " + e + " is not supported.";
			    }, f = function(e, t) {
			        return u[e] + " - " + t;
			    }, l = function(e) {
			        a(e), this.currentLogLevel = e || r, this.sendMessageToEditor = undefined;
			    };
			    return l.prototype = {
			        LOG_LEVEL_DEBUG: n,
			        LOG_LEVEL_INFO: r,
			        LOG_LEVEL_WARN: i,
			        LOG_LEVEL_ERROR: s,
			        LOG_LEVEL_SILENT: o,
			        setSendMessageToEditor: function(e) {
			            this.sendMessageToEditor = e;
			        },
			        setLogLevel: function(e) {
			            a(e), this.currentLogLevel = e;
			        },
			        log: function(t, r) {
			            arguments.length === 1 && (r = t, t = n);
			            if (t < this.currentLogLevel) return;
			            this.sendMessageToEditor && this.sendMessageToEditor("spelled.debug.consoleMessage", {
			                level: u[t],
			                text: r
			            }), e(f(t, r));
			        },
			        debug: function(e) {
			            this.log(n, e);
			        },
			        info: function(e) {
			            this.log(r, e);
			        },
			        warn: function(e) {
			            this.log(i, e);
			        },
			        error: function(e) {
			            this.log(s, e);
			        }
			    }, l;
			}), define("QGfnGX0u4msE+kZC/56cY/9TOvn7ZCzFFI10N1Erczg=", [ "xzulUmNYw/38rNcu3Y7xU3DRAD5hGCLMNWsYeDxH4jc=" ], function(e) {
			    "use strict";
			    var t = 63, n = 1, r = e.addNode, i = e.getNode, s = e.eachNode, o = function(e) {
			        var t = [];
			        while (e > 0) t.push(0), e--;
			        return t;
			    }, u = function(e, t) {
			        var n = t.length, r = 0;
			        for (var i = 0; i < n; i++) r += Math.pow(t[i] - e, 2);
			        return Math.sqrt(r / n);
			    }, a = function(e) {
			        return {
			            children: [],
			            id: e,
			            metrics: [ 0, 0, 0, 0 ],
			            values: o(t)
			        };
			    }, f = function(e) {
			        var r = e.values, i = 0, s = Number.MAX_VALUE, o = 0, a = 0;
			        for (var f = 0, l = r.length; f < l; f++) {
			            var c = r[f];
			            if (c === 0) continue;
			            c < s && (s = c), c > o && (o = c), a += c;
			        }
			        a !== 0 ? i = a / t : s = 0;
			        var h = e.metrics;
			        h[0] = i.toFixed(n), h[1] = s.toFixed(n), h[2] = o.toFixed(n), h[3] = u(i, r).toFixed(2);
			    }, l = function(e) {
			        var t = e.values;
			        t.shift(), t.push(0);
			    }, c = function(e) {
			        var t = e.values;
			        for (var n = 0, r = t.length; n < r; n++) t[n] = 0;
			    }, h = function() {
			        this.tree = null, this.timestamps = o(t), this.totalTickTimeInMs = 0, this.numTicks = 0;
			    };
			    return h.prototype = {
			        init: function() {
			            this.tree = a("total"), r(this.tree, "total", a("render")), r(this.tree, "total", a("update"));
			        },
			        addNode: function(e, t) {
			            var n = r(this.tree, t, a(e));
			            if (!n) throw 'Could not add node "' + e + '" to parent node "' + t + '".';
			        },
			        startTick: function(e, t) {
			            this.totalTickTimeInMs += t, this.numTicks++;
			            var n = this.timestamps;
			            n.shift(), n.push(e), s(this.tree, l);
			        },
			        updateNode: function(e, t) {
			            var n = i(this.tree, e);
			            if (!n) return;
			            n.values[n.values.length - 1] += t;
			        },
			        getMetrics: function(e) {
			            return s(this.tree, f), this.tree;
			        },
			        getAverageTickTime: function() {
			            return Math.round(this.totalTickTimeInMs / this.numTicks);
			        },
			        reset: function() {
			            this.totalTickTimeInMs = 0, this.numTicks = 0, s(this.tree, c);
			        }
			    }, h;
			}), define("JoXWj40Y1mozCrRKdElU4QZ2XbCHKUve+HAQqeLSgQ8=", function() {
			    var e = 8, t = "=", n = 0, r = function(t) {
			        var n = [], r = (1 << e) - 1, i = t.length * e, s;
			        for (s = 0; s < i; s += e) n[s >> 5] |= (t.charCodeAt(s / e) & r) << 32 - e - s % 32;
			        return n;
			    }, i = function(e) {
			        var t = [], n = e.length, r, i;
			        for (r = 0; r < n; r += 2) {
			            i = parseInt(e.substr(r, 2), 16);
			            if (!!isNaN(i)) return "INVALID HEX STRING";
			            t[r >> 3] |= i << 24 - 4 * (r % 8);
			        }
			        return t;
			    }, s = function(e) {
			        var t = n ? "0123456789ABCDEF" : "0123456789abcdef", r = "", i = e.length * 4, s, o;
			        for (s = 0; s < i; s += 1) o = e[s >> 2] >> (3 - s % 4) * 8, r += t.charAt(o >> 4 & 15) + t.charAt(o & 15);
			        return r;
			    }, o = function(e) {
			        var n = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", r = "", i = e.length * 4, s, o, u;
			        for (s = 0; s < i; s += 3) {
			            u = (e[s >> 2] >> 8 * (3 - s % 4) & 255) << 16 | (e[s + 1 >> 2] >> 8 * (3 - (s + 1) % 4) & 255) << 8 | e[s + 2 >> 2] >> 8 * (3 - (s + 2) % 4) & 255;
			            for (o = 0; o < 4; o += 1) s * 8 + o * 6 <= e.length * 32 ? r += n.charAt(u >> 6 * (3 - o) & 63) : r += t;
			        }
			        return r;
			    }, u = function(e, t) {
			        return e >>> t | e << 32 - t;
			    }, a = function(e, t) {
			        return e >>> t;
			    }, f = function(e, t, n) {
			        return e & t ^ ~e & n;
			    }, l = function(e, t, n) {
			        return e & t ^ e & n ^ t & n;
			    }, c = function(e) {
			        return u(e, 2) ^ u(e, 13) ^ u(e, 22);
			    }, h = function(e) {
			        return u(e, 6) ^ u(e, 11) ^ u(e, 25);
			    }, p = function(e) {
			        return u(e, 7) ^ u(e, 18) ^ a(e, 3);
			    }, d = function(e) {
			        return u(e, 17) ^ u(e, 19) ^ a(e, 10);
			    }, v = function(e, t) {
			        var n = (e & 65535) + (t & 65535), r = (e >>> 16) + (t >>> 16) + (n >>> 16);
			        return (r & 65535) << 16 | n & 65535;
			    }, m = function(e, t, n, r) {
			        var i = (e & 65535) + (t & 65535) + (n & 65535) + (r & 65535), s = (e >>> 16) + (t >>> 16) + (n >>> 16) + (r >>> 16) + (i >>> 16);
			        return (s & 65535) << 16 | i & 65535;
			    }, g = function(e, t, n, r, i) {
			        var s = (e & 65535) + (t & 65535) + (n & 65535) + (r & 65535) + (i & 65535), o = (e >>> 16) + (t >>> 16) + (n >>> 16) + (r >>> 16) + (i >>> 16) + (s >>> 16);
			        return (o & 65535) << 16 | s & 65535;
			    }, y = function(e, t, n) {
			        var r, i, s, o, u, a, y, b, w, E, S, x, T, N, C, k = [], L;
			        if (n === "SHA-224" || n === "SHA-256") x = (t + 65 >> 9 << 4) + 15, C = [ 1116352408, 1899447441, 3049323471, 3921009573, 961987163, 1508970993, 2453635748, 2870763221, 3624381080, 310598401, 607225278, 1426881987, 1925078388, 2162078206, 2614888103, 3248222580, 3835390401, 4022224774, 264347078, 604807628, 770255983, 1249150122, 1555081692, 1996064986, 2554220882, 2821834349, 2952996808, 3210313671, 3336571891, 3584528711, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700, 1986661051, 2177026350, 2456956037, 2730485921, 2820302411, 3259730800, 3345764771, 3516065817, 3600352804, 4094571909, 275423344, 430227734, 506948616, 659060556, 883997877, 958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, 2227730452, 2361852424, 2428436474, 2756734187, 3204031479, 3329325298 ], n === "SHA-224" ? S = [ 3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428 ] : S = [ 1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225 ];
			        e[t >> 5] |= 128 << 24 - t % 32, e[x] = t, L = e.length;
			        for (T = 0; T < L; T += 16) {
			            r = S[0], i = S[1], s = S[2], o = S[3], u = S[4], a = S[5], y = S[6], b = S[7];
			            for (N = 0; N < 64; N += 1) N < 16 ? k[N] = e[N + T] : k[N] = m(d(k[N - 2]), k[N - 7], p(k[N - 15]), k[N - 16]), w = g(b, h(u), f(u, a, y), C[N], k[N]), E = v(c(r), l(r, i, s)), b = y, y = a, a = u, u = v(o, w), o = s, s = i, i = r, r = v(w, E);
			            S[0] = v(r, S[0]), S[1] = v(i, S[1]), S[2] = v(s, S[2]), S[3] = v(o, S[3]), S[4] = v(u, S[4]), S[5] = v(a, S[5]), S[6] = v(y, S[6]), S[7] = v(b, S[7]);
			        }
			        switch (n) {
			          case "SHA-224":
			            return [ S[0], S[1], S[2], S[3], S[4], S[5], S[6] ];
			          case "SHA-256":
			            return S;
			          default:
			            return [];
			        }
			    }, b = function(t, n) {
			        this.sha224 = null, this.sha256 = null, this.strBinLen = null, this.strToHash = null;
			        if ("HEX" === n) {
			            if (0 !== t.length % 2) return "TEXT MUST BE IN BYTE INCREMENTS";
			            this.strBinLen = t.length * 4, this.strToHash = i(t);
			        } else {
			            if ("ASCII" !== n && "undefined" != typeof n) return "UNKNOWN TEXT INPUT TYPE";
			            this.strBinLen = t.length * e, this.strToHash = r(t);
			        }
			    };
			    return b.prototype = {
			        getHash: function(e, t) {
			            var n = null, r = this.strToHash.slice();
			            switch (t) {
			              case "HEX":
			                n = s;
			                break;
			              case "B64":
			                n = o;
			                break;
			              default:
			                return "FORMAT NOT RECOGNIZED";
			            }
			            switch (e) {
			              case "SHA-224":
			                return null === this.sha224 && (this.sha224 = y(r, this.strBinLen, e)), n(this.sha224);
			              case "SHA-256":
			                return null === this.sha256 && (this.sha256 = y(r, this.strBinLen, e)), n(this.sha256);
			              default:
			                return "HASH NOT RECOGNIZED";
			            }
			        },
			        getHMAC: function(t, n, u, a) {
			            var f, l, c, h, p, d, v = [], m = [];
			            switch (a) {
			              case "HEX":
			                f = s;
			                break;
			              case "B64":
			                f = o;
			                break;
			              default:
			                return "FORMAT NOT RECOGNIZED";
			            }
			            switch (u) {
			              case "SHA-224":
			                d = 224;
			                break;
			              case "SHA-256":
			                d = 256;
			                break;
			              default:
			                return "HASH NOT RECOGNIZED";
			            }
			            if ("HEX" === n) {
			                if (0 !== t.length % 2) return "KEY MUST BE IN BYTE INCREMENTS";
			                l = i(t), p = t.length * 4;
			            } else {
			                if ("ASCII" !== n) return "UNKNOWN KEY INPUT TYPE";
			                l = r(t), p = t.length * e;
			            }
			            64 < p / 8 ? (l = y(l, p, u), l[15] &= 4294967040) : 64 > p / 8 && (l[15] &= 4294967040);
			            for (c = 0; c <= 15; c += 1) v[c] = l[c] ^ 909522486, m[c] = l[c] ^ 1549556828;
			            return h = y(v.concat(this.strToHash), 512 + this.strBinLen, u), h = y(m.concat(h), 512 + d, u), f(h);
			        }
			    }, b;
			}), define("Z2l7EkM9fBMD6CDNrF10FVKH9lTCDaUcSjjB1q/TdgE=", [ "JoXWj40Y1mozCrRKdElU4QZ2XbCHKUve+HAQqeLSgQ8=" ], function(e) {
			    "use strict";
			    return function(t) {
			        var n = new e(t, "ASCII");
			        return n.getHash("SHA-256", "B64");
			    };
			}), define("aa1pimqD6igbBAjIMosAzz91SOAoYOjfpQNmoIqX0iE=", [ "Z2l7EkM9fBMD6CDNrF10FVKH9lTCDaUcSjjB1q/TdgE=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=" ], function(e, t) {
			    "use strict";
			    var n;
			    return function(r, i, s) {
			        return n || (n = {
			            require: function(n) {
			                var o = {
			                    libraryManager: i ? r : undefined,
			                    hashModuleId: e,
			                    loadingAllowed: i,
			                    libraryUrl: s
			                };
			                return t.ModuleLoader.require(n, null, o);
			            }
			        }), n;
			    };
			}), define("hil8xb1IimJN9xLR8nPd5HFdl6J0s1wfcAnkDTTWJEw=", [ "UDKOzFuhCFMgpnBYA5n7LsFCrO6xRaePEI2Hi2gAn6I=", "bFOXtEjmXJ1lK4AExMZNtVOOBi6q4Gj93XmA7N0camQ=", "rvasITs2FBDcIVclbnPocpNbQvHuu/vr/WHZ0WRVg5s=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s) {
			    "use strict";
			    var o = 0, u = function() {
			        return o++;
			    }, a = function(e) {
			        return r.jsonCoder.decode(e);
			    }, f = function(e, t) {
			        var n = s.bind(r.createImageLoader, null, e), i = s.bind(r.createSoundLoader, null, t), o = s.bind(r.createTextLoader, null, a);
			        return {
			            jpeg: n,
			            png: n,
			            mp3: i,
			            wav: i,
			            ogg: i,
			            json: o
			        };
			    }, l = function(e, t, n) {
			        return t === "auto" && (s.isObject(n) ? t = s.last(n.libraryPath.split(".")) : t = s.last(n.split("."))), e[t];
			    }, c = function(e, t, n, r, i) {
			        return {
			            id: e,
			            libraryPaths: t,
			            numCompleted: 0,
			            name: r.name,
			            next: i,
			            type: r.type ? r.type : "auto",
			            libraryUrl: n,
			            omitCache: !!r.omitCache,
			            onLoadingCompleted: r.onLoadingCompleted,
			            isMetaDataLoad: r.isMetaDataLoad !== undefined ? r.isMetaDataLoad : !0
			        };
			    }, h = function(t, n, r, o) {
			        o.numCompleted++;
			        var u = o.libraryPaths, a = u.length, f = o.numCompleted / a, l = o.name;
			        t.publish([ i.RESOURCE_PROGRESS, l ], [ f, o.numCompleted, a ]);
			        if (o.numCompleted === a) {
			            var c = s.reduce(u, function(e, t) {
			                return s.isObject(t) ? e[t.libraryPath] = n[t.libraryPath] : e[t] = n[t], e;
			            }, {});
			            o.isMetaDataLoad && e(c), o.onLoadingCompleted && o.onLoadingCompleted(c), delete r[o.id], l && t.publish([ i.RESOURCE_LOADING_COMPLETED, l ], [ c ]), o.next && o.next();
			        }
			    }, p = function(e, t, n, r, i, s) {
			        if (!s) throw 'Error: Resource "' + i + '" from loading process "' + r.id + '" is undefined or empty on loading completed.';
			        t[i] = s, h(e, t, n, r);
			    }, d = function(e, t, n, r, i) {
			        throw 'Error: Loading resource "' + i + '" failed.';
			    }, v = function(e, t, n, r, i) {
			        throw 'Error: Loading resource "' + i + '" timed out.';
			    }, m = function(e, t, n, r, i) {
			        var o = i.omitCache, u = i.libraryPaths;
			        for (var a = 0, f = u.length; a < f; a++) {
			            var c = u[a], h;
			            s.isObject(c) ? (c = u[a].libraryPath, h = u[a].libraryPathUrlUsedForLoading) : h = c;
			            if (!o) {
			                var m = e[c];
			                if (m) {
			                    p(t, e, r, i, c, m);
			                    continue;
			                }
			            }
			            var g = l(n, i.type, c);
			            if (!g) throw 'Error: Unable to load resource of type "' + i.type + '".';
			            var y = g(i.libraryUrl, h, s.bind(p, null, t, e, r, i, c), s.bind(d, null, t, e, r, i, c), s.bind(v, null, t, e, r, i, c));
			            if (!y) throw 'Could not create a loader for resource "' + c + '".';
			            y.start();
			        }
			    }, g = function(e, t) {
			        this.eventManager = e, this.loadingProcesses = {}, this.libraryUrl = t, this.resourceTypeToLoaderFactory, this.cache = {
			            metaData: {},
			            resource: {}
			        };
			    };
			    return g.prototype = {
			        get: function(e) {
			            var t = this.cache;
			            return t.metaData[e] || t.resource[e];
			        },
			        getByLibraryId: function(e) {
			            return this.get(n(e));
			        },
			        getMetaDataRecordsByType: function(e) {
			            return s.reduce(this.cache.metaData, function(t, n, r) {
			                return n.type === e && (t[r] = n), t;
			            }, {});
			        },
			        addToCache: function(t) {
			            s.extend(this.cache.metaData, t), e(this.cache.metaData);
			        },
			        isAvailable: function(e) {
			            var r = this.cache;
			            for (var i = 0, s = e.length, o; i < s; i++) {
			                o = r.metaData[n(e[i])];
			                if (!o) return !1;
			                if (o.file && !r.resource[t(o.namespace, o.file)]) return !1;
			            }
			            return !0;
			        },
			        free: function() {
			            this.cache.resource = {};
			        },
			        load: function(e, t, n) {
			            if (!this.resourceTypeToLoaderFactory) throw "Error: Library manager is not properly initialized.";
			            if (e.length === 0) throw "Error: No library paths provided.";
			            var r = u(), i = c(r, e, this.libraryUrl, t || {}, n);
			            return this.loadingProcesses[r] = i, m(i.isMetaDataLoad ? this.cache.metaData : this.cache.resource, this.eventManager, this.resourceTypeToLoaderFactory, this.loadingProcesses, i), r;
			        },
			        init: function(e, t) {
			            this.resourceTypeToLoaderFactory = f(t, e);
			        }
			    }, g;
			}), define("5DXS8p6p/6XPSVo/sZHjU842Rl9MoWWPVu5I+ZXlneQ=", [ "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "Njtu1p/lIocQu9jigRUr61eNAmO/ZIR7GBcFv6RVQkk=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n) {
			    "use strict";
			    var r = [], i = [], s = {}, o = {}, u = {}, a = function(e) {
			        r.push(e);
			        var t = e.type, n = t === "keyDown", a = t === "keyUp";
			        if (n || a) {
			            var l = e.keyCode, c = s[l] === n;
			            if (c) return;
			            s[l] = n;
			            var h = f(u, l, n);
			            h && i.push(h);
			        }
			        var p = o[t];
			        if (p) for (var d = 0, v = p.length; d < v; d++) p[d].call(null, e);
			    }, f = function(e, t, n) {
			        for (var r in e) {
			            var i = e[r];
			            for (var s in i) if (s == t) {
			                var o = i[s];
			                return (n ? "start" : "stop") + o.substr(0, 1).toUpperCase() + o.substr(1, o.length);
			            }
			        }
			    }, l = function(e, t) {
			        return {
			            type: e,
			            keyCode: t
			        };
			    }, c = function(t, n) {
			        this.nativeInput = e.createInput(t, n);
			    };
			    return c.prototype = {
			        init: function() {
			            this.nativeInput.setInputEventListener(a);
			        },
			        destroy: function() {
			            this.nativeInput.removeInputEventListener();
			        },
			        getInputEvents: function() {
			            return r;
			        },
			        clearInputEvents: function() {
			            r.length = 0;
			        },
			        isKeyPressed: function(e) {
			            return s[e];
			        },
			        injectKeyEvent: function(e, t) {
			            a(l(e, t));
			        },
			        addListener: function(e, t) {
			            var n = o[e] || (o[e] = []);
			            n.push(t);
			        },
			        removeListener: function(e, t) {
			            var r = o[e];
			            if (!r) return;
			            o[e] = n.filter(r, function(e) {
			                return e === t;
			            });
			        },
			        addInputContext: function(e, t) {
			            u[e] = t;
			        },
			        removeInputContext: function(e) {
			            delete u[e];
			        },
			        getCommands: function() {
			            return i;
			        },
			        clearCommands: function() {
			            i.length = 0;
			        },
			        KEY: t
			    }, c;
			}), define("+I3msXuDoYiTvtdmx0dXf3YC2HxHEmfwkQ6Qjzj9l8E=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    function t() {
			        return {
			            subNodes: {},
			            elements: []
			        };
			    }
			    function n(t) {
			        return t ? e.reduce(t.subNodes, function(e, t) {
			            return e.concat(n(t));
			        }, t.elements) : [];
			    }
			    function r(t, n, r) {
			        return e.reduce(n, function(e, t) {
			            return e === undefined ? undefined : (r !== undefined && r(e, t), e.subNodes[t]);
			        }, t);
			    }
			    return {
			        create: function() {
			            return t();
			        },
			        add: function(e, n, i) {
			            var s = r(e, n, function(e, n) {
			                e.subNodes.hasOwnProperty(n) || (e.subNodes[n] = t());
			            });
			            s.elements.push(i);
			        },
			        remove: function(t, n, i) {
			            var s = r(t, n);
			            i === undefined ? s.elements.length = 0 : s.elements = e.filter(s.elements, function(e) {
			                return e !== i;
			            });
			        },
			        get: function(e, t) {
			            return n(r(e, t));
			        }
			    };
			}), define("6LWBMS9D/d2r0J5+eQvSlL9x6G8sa+U+ODk4ht82dGw=", [ "+I3msXuDoYiTvtdmx0dXf3YC2HxHEmfwkQ6Qjzj9l8E=", "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n) {
			    "use strict";
			    function o() {
			        this.subscribers = e.create();
			    }
			    var r = function(e) {
			        return n.isArray(e) ? e : [ e ];
			    }, i = !1, s = function(e, t) {
			        var r = t.callback, i = n.after(t.events.length, function() {
			            r();
			        });
			        n.each(t.events, function(t) {
			            var n = function(r) {
			                t.subscriber && t.subscriber(r), e.unsubscribe(t.scope, n), i();
			            };
			            e.subscribe(t.scope, n);
			        });
			    };
			    return o.prototype = {
			        subscribe: function(n, i) {
			            var s = r(n);
			            e.add(this.subscribers, s, i), this.publish(t.SUBSCRIBE, [ s, i ]);
			        },
			        unsubscribe: function(n, i) {
			            var s = r(n);
			            e.remove(this.subscribers, s, i), this.publish(t.UNSUBSCRIBE, [ s, i ]);
			        },
			        unsubscribeAll: function(n) {
			            var i = r(n);
			            e.remove(this.subscribers, i), this.publish(t.UNSUBSCRIBE, [ i ]);
			        },
			        publish: function(t, i) {
			            var s = e.get(this.subscribers, r(t)), o = r(i);
			            return n.each(s, function(e) {
			                e.apply(undefined, o);
			            }), !0;
			        },
			        waitFor: function(e, t) {
			            return i = {
			                events: [ {
			                    scope: r(e),
			                    subscriber: t
			                } ]
			            }, this;
			        },
			        and: function(e, t) {
			            if (!i) throw 'A call to the method "and" must be chained to a previous call to "waitFor".';
			            return i.events.push({
			                scope: r(e),
			                subscriber: t
			            }), this;
			        },
			        resume: function(e) {
			            if (!i) throw 'A call to the method "resume" must be chained to a previous call to "waitFor" or "and".';
			            i.callback = e, s(this, i), i = !1;
			        },
			        EVENT: t
			    }, o;
			}), define("GSV7+xwIB59dg5QN6WD1h1rWzVc9OwabH1SWt8Pk1c4=", [ "z7TX6BsmUcv0nH/bqr0j7VkT7tQUPxwYZT67+lzEXGk=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s) {
			    "use strict";
			    var o = function(t, n) {
			        return n ? e(t, n, !0) : t;
			    }, u = function(e, t) {
			        return s.contains(e, t) ? t : !1;
			    }, a = function(e, t) {
			        return s.isArray(t) && t.length === 2 ? (t[0] = parseFloat(t[0]), t[1] = parseFloat(t[1]), t) : !1;
			    }, f = s.extend({
			        screenMode: {
			            validValues: [ "fill", "fit", "fixed" ],
			            configurable: !0,
			            extractor: u
			        },
			        screenSize: {
			            configurable: !0,
			            extractor: a
			        },
			        currentScreenSize: {
			            configurable: !1
			        },
			        id: {
			            configurable: !0
			        },
			        mode: {
			            validValues: [ "deployed", "development_embedded", "development_standalone" ],
			            configurable: !0
			        },
			        quadTreeSize: {
			            configurable: !0
			        },
			        projectId: {
			            configurable: !0
			        },
			        supportedLanguages: {
			            configurable: !0
			        },
			        defaultLanguage: {
			            configurable: !0
			        },
			        currentLanguage: {
			            configurable: !0
			        },
			        loadingScene: {
			            configurable: !0
			        }
			    }, r.configurationOptions.validOptions), l = s.extend({
			        screenMode: "fixed",
			        screenSize: [ 300, 200 ],
			        currentScreenSize: [ 300, 200 ],
			        quadTreeSize: 1048576,
			        projectId: "",
			        id: "spell",
			        "platform.id": r.platformDetails.getPlatform(),
			        "platform.hasPlentyRAM": r.platformDetails.hasPlentyRAM()
			    }, r.configurationOptions.defaultOptions), c = function(e, t, n, r, i) {
			        var s = n[r];
			        if (s) {
			            if (!s.configurable) return e;
			            var o = s.extractor ? s.extractor(s.validValues, i) : i;
			            e[r] = o === undefined ? s.extractor ? s.extractor(s.validValues, t[r]) : o : o;
			        } else e[r] = i;
			    }, h = function(e) {
			        this.config = l, this.eventManager = e, e.subscribe([ i.AVAILABLE_SCREEN_SIZE_CHANGED ], s.bind(function(n) {
			            var r = this.config, s = r.screenMode || "fixed", u = r.screenAspectRatio > 0, a = r.screenSize;
			            if (u) r.currentScreenSize = o(n, r.screenAspectRatio); else if (s === "fit") {
			                var f = [ t.clamp(n[0], 0, a[0]), t.clamp(n[1], 0, a[1]) ];
			                r.currentScreenSize = o(f, a[0] / a[1]);
			            } else if (s === "fixed") r.currentScreenSize = a; else {
			                if (s !== "fill") throw "Error: Screen mode '" + s + "' is not supported.";
			                r.currentScreenSize = [ n[0], n[1] ];
			            }
			            e.publish(i.SCREEN_RESIZE, [ r.currentScreenSize ]);
			        }, this));
			    };
			    return h.prototype = {
			        setValue: function(e, t) {
			            var o = this.config;
			            if (e === "defaultLanguage") o.currentLanguage = t; else if (e === "currentLanguage") {
			                s.contains(o.supportedLanguages, t) && (o.currentLanguage = t);
			                return;
			            }
			            c(o, l, f, e, t), e === "screenAspectRatio" || e === "screenMode" ? this.eventManager.publish(i.AVAILABLE_SCREEN_SIZE_CHANGED, [ r.getAvailableScreenSize(this.getValue("id")) ]) : e === "screenSize" && n.copy(o.currentScreenSize, t);
			        },
			        getValue: function(e) {
			            return this.config[e];
			        },
			        setConfig: function(e) {
			            for (var t in e) {
			                if (t === "supportedLanguages" || t === "defaultLanguage" || t === "currentLanguage") continue;
			                this.setValue(t, e[t]);
			            }
			            e.supportedLanguages && this.setValue("supportedLanguages", e.supportedLanguages), e.defaultLanguage && this.setValue("defaultLanguage", e.defaultLanguage), e.currentLanguage && this.setValue("currentLanguage", e.currentLanguage);
			        }
			    }, h;
			}), define("Qpj+fizmi2T5BUE0zCUFDzTWLiVETxC7mbwnh7FRpaU=", function() {
			    "use strict";
			    var e = function(e) {
			        this.assets = {}, this.libraryManager = e;
			    };
			    return e.prototype = {
			        add: function(e, t) {
			            this.assets[e] = t;
			        },
			        get: function(e) {
			            return this.assets[e];
			        },
			        getLibraryIdByResourceId: function(e) {
			            var t = this.assets, n = [];
			            for (var r in t) {
			                var i = t[r];
			                i.resourceId && i.resourceId === e && n.push(r.slice(r.indexOf(":") + 1));
			            }
			            return n;
			        },
			        has: function(e) {
			            return !!this.assets[e];
			        },
			        injectResources: function(e) {
			            var t = this.assets, n = this.libraryManager;
			            for (var r in t) {
			                var i = t[r], s = i.resourceId;
			                if (!s) continue;
			                if (!e[s]) continue;
			                var o = n.get(s);
			                if (!o) return;
			                i.resource = o;
			            }
			        },
			        free: function() {
			            this.assets = {};
			        }
			    }, e;
			}), define("rWsBG/X7JSJQ7oY8QeDfmNOcjk/hz9VLciawllnhB8I=", [ "x+aoL4OeksmAAgV8+dHtcYBBr7EChbSqGxZQUUVVR4A=" ], function(e) {
			    "use strict";
			    var t = function() {
			        this.keys = [], this.values = [];
			    };
			    return t.prototype = {
			        add: function(e, t) {
			            var n = this.keys, r = this.values, i = n.indexOf(e);
			            return i === -1 ? (n.push(e), r.push(t)) : r[i] = t, this;
			        },
			        insert: function(e, t, n) {
			            var r = this.keys.indexOf(e);
			            return r !== -1 && this.removeByIndex(r), this.keys.splice(n, 0, e), this.values.splice(n, 0, t), this;
			        },
			        getByIndex: function(e) {
			            return this.values[e];
			        },
			        getByKey: function(e) {
			            return this.getByIndex(this.keys.indexOf(e));
			        },
			        hasKey: function(e) {
			            return this.keys.indexOf(e) !== -1;
			        },
			        removeByIndex: function(t) {
			            return e(this.keys, t), e(this.values, t), this;
			        },
			        removeByKey: function(e) {
			            return this.removeByIndex(this.keys.indexOf(e)), this;
			        },
			        each: function(e) {
			            var t = this.keys, n = this.values;
			            for (var r = 0, i = t.length; r < i; r++) {
			                var s = t[r], o = n[r];
			                e(o, s);
			            }
			            return this;
			        },
			        clear: function() {
			            return this.keys.length = 0, this.values.length = 0, this;
			        },
			        size: function() {
			            return this.keys.length;
			        }
			    }, t;
			}), define("JSVeahu1i9Ml9XJZopPKwXtCNWIdjrstPzeqwZTBUpU=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    var t = function(n) {
			        return e.reduce(n, function(n, r) {
			            return n.push(r), e.has(r, "children") ? n.concat(t(r.children)) : n;
			        }, []);
			    };
			    return function(n) {
			        var r = e.isArray(n) ? n : [ n ];
			        return t(r);
			    };
			}), define("h2aMiZCagVvEo7aSt+UFK1OYzb19iS+Je86Iito/sUs=", [ "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "kuo4CZ9KQ512nkgHgkhEQw7SM9XaLIpsYBcjXhzKG0Y=", "JSVeahu1i9Ml9XJZopPKwXtCNWIdjrstPzeqwZTBUpU=", "rWsBG/X7JSJQ7oY8QeDfmNOcjk/hz9VLciawllnhB8I=", "TpUPENVsbpktS1yxz8LZH4ftV7yQhfNp9dpn/zLcys4=", "d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", "rvasITs2FBDcIVclbnPocpNbQvHuu/vr/WHZ0WRVg5s=", "kWM1PJpBvsvnYJoun0Mv1hu480p1CKPXc+pLuoDzXiA=", "v8fOdhNCtMEZStOrNxspT+wYpcqnI29sSZZku+1iaIw=", "VARx5D0ga68cy8NlL0048TNzV6HQOz8e4ZC9Q2rlpD4=", "RHForCY775HrCxRbFeVX9Spz8YmenJsOpg1HHlNx44o=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s, o, u, a, f, l, c, h, p) {
			    "use strict";
			    var d = t.CAMERA_COMPONENT_ID, v = new l, m = function(e, t, n, r, i) {
			        var s = e.values;
			        for (var o = 0, u = s.length; o < u; o++) {
			            v.start();
			            var a = s[o];
			            (!r || a.config.active) && a.prototype[t].apply(a, i), n.updateNode(e.keys[o], v.stop());
			        }
			    }, g = function(e, t, n, r, s, o) {
			        var u = p.reduce(r.input, function(e, r) {
			            var i = t.getComponentMapById(r.componentId);
			            if (!i) throw "Error: No component list for component template id '" + r.componentId + "' available.";
			            if (r.name === "config") throw "Error: The system '" + n + "' uses the reserved keyword 'config' as a local alias for its input.";
			            return e[r.name] = i, e;
			        }, {
			            config: o
			        }), f = e.moduleLoader.require(a(n));
			        return i(f, [ e ], u);
			    }, y = function(e) {
			        return p.reduce(e, function(e, t) {
			            return e[t.name] = f(t["default"]), e;
			        }, {});
			    }, b = function(e, t, n, i, s) {
			        return p.reduce(i, function(r, i) {
			            var u = i.id, a = n.get(o(u));
			            if (!a) throw "Error: Could not get template for id '" + u + "'.";
			            return r.add(u, g(e, t, u, a, s, p.defaults(f(i.config), y(a.config))));
			        }, new r);
			    }, w = function(e) {
			        return !0;
			    }, E = function(e, t) {
			        for (var n in e) {
			            var r = e[n];
			            if (r.hasKey(t)) return n;
			        }
			    }, S = function(e, t, n) {
			        for (var r = 0, i = t.length; r < i; r++) {
			            var s = t[r];
			            e.addNode(s.id, n);
			        }
			    }, x = function(e, t, n, r, i, s, o) {
			        this.spell = e, this.entityManager = t, this.libraryManager = n, this.statisticsManager = r, this.isModeDevelopment = i, this.executionGroups = {
			            render: null,
			            update: null
			        }, this.sceneConfig = s, this.initialConfig = o, this.script = null;
			    };
			    return x.prototype = {
			        render: function(e, t) {
			            m(this.executionGroups.render, "process", this.statisticsManager, !0, [ this.spell, e, t ]);
			        },
			        update: function(e, t) {
			            m(this.executionGroups.update, "process", this.statisticsManager, !0, [ this.spell, e, t ]);
			        },
			        init: function() {
			            var e = this.spell, t = this.sceneConfig, n = this.initialConfig;
			            this.statisticsManager.init();
			            if (!w(t)) {
			                e.logger.error('Could not start scene "' + t.name + '" because no camera entity was found. A scene must have at least one active camera entity.');
			                return;
			            }
			            var r = this.entityManager, i = this.libraryManager, o = this.executionGroups;
			            o.render = b(e, r, i, t.systems.render, this.isModeDevelopment), o.update = b(e, r, i, t.systems.update, this.isModeDevelopment), S(this.statisticsManager, t.systems.render, "render"), S(this.statisticsManager, t.systems.update, "update"), m(o.render, "init", this.statisticsManager, !1, [ e, t, n ]), m(o.update, "init", this.statisticsManager, !1, [ e, t, n ]);
			            var u = a(s(t.namespace, t.name));
			            this.script = e.moduleLoader.require(u), this.script.init(e, t, n), m(o.render, "activate", this.statisticsManager, !0, [ e, t, n ]), m(o.update, "activate", this.statisticsManager, !0, [ e, t, n ]);
			        },
			        destroy: function() {
			            var e = this.executionGroups, t = this.spell, n = this.sceneConfig;
			            m(e.render, "deactivate", this.statisticsManager, !0, [ t, n ]), m(e.update, "deactivate", this.statisticsManager, !0, [ t, n ]), this.script.destroy(this.spell, n), m(e.render, "destroy", this.statisticsManager, !1, [ t, n ]), m(e.update, "destroy", this.statisticsManager, !1, [ t, n ]);
			        },
			        restartSystem: function(e, t, n) {
			            var r = this.executionGroups;
			            t || (t = E(r, e));
			            var i = r[t];
			            if (!i) return;
			            var s = i.getByKey(e);
			            if (!s) return;
			            n || (n = s.config);
			            var u = this.spell;
			            s.config.active && s.prototype.deactivate.call(s, u), s.prototype.destroy.call(s, u);
			            var a = g(u, this.entityManager, e, this.libraryManager.get(o(e)), this.isModeDevelopment, n);
			            a.prototype.init.call(a, u, this.sceneConfig, this.initialConfig), a.config.active && a.prototype.activate.call(a, u, this.sceneConfig, this.initialConfig), i.add(e, a);
			        },
			        addSystem: function(e, t, n, r) {
			            var i = this.executionGroups[t];
			            if (!i) return;
			            var s = this.spell, a = this.isModeDevelopment, f = this.libraryManager;
			            f.load(u([ e ]), undefined, function() {
			                var t = g(s, s.entityManager, e, f.get(o(e)), a, r);
			                t.prototype.init.call(t, s), t.config.active && t.prototype.activate.call(t, s), i.insert(e, t, n);
			            });
			        },
			        removeSystem: function(e, t) {
			            var n = this.executionGroups[t];
			            if (!n) return;
			            var r = this.spell, i = n.getByKey(e);
			            i.config.active && i.prototype.deactivate.call(i, r), i.prototype.destroy.call(i, r), n.removeByKey(e);
			        },
			        moveSystem: function(e, t, n, r) {
			            var i = this.executionGroups[t], s = this.executionGroups[n];
			            if (!i || !s) return;
			            var o = i.getByKey(e);
			            if (!o) return;
			            i.removeByKey(e), s.insert(e, o, r);
			        },
			        updateSystem: function(e, t, n) {
			            if (!n) return;
			            var r = this.executionGroups;
			            t || (t = E(r, e));
			            var i = r[t];
			            if (!i) return;
			            var s = i.getByKey(e);
			            if (!s) return;
			            var o = n.active !== undefined && s.config !== n.active;
			            p.extend(s.config, f(n)), o && (n.active ? s.prototype.activate.call(s, this.spell, this.sceneConfig, this.initialConfig) : s.prototype.deactivate.call(s, this.spell, this.sceneConfig));
			        }
			    }, x;
			}), define("kWM1PJpBvsvnYJoun0Mv1hu480p1CKPXc+pLuoDzXiA=", [ "rvasITs2FBDcIVclbnPocpNbQvHuu/vr/WHZ0WRVg5s=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t) {
			    "use strict";
			    return function(n) {
			        return t.map(n, e);
			    };
			}), define("MhHL0uYRQ50mDamX7ZC1uHXvJGt8/QI3z9dfvWa/w3g=", [ "ingT4RnRpUiJVUpqmIZzn0mb4bWOxvdCL7jVnvrEevs=", "UDKOzFuhCFMgpnBYA5n7LsFCrO6xRaePEI2Hi2gAn6I=", "3NNm1Xr+NiUMHZ6h4rjokfmOhn1qi0l9m+2oT/bl0aI=", "+kMCuNhMJbCFFz81NxZMk0B1yxR7pTV+H67Y6qVKnvY=", "kWM1PJpBvsvnYJoun0Mv1hu480p1CKPXc+pLuoDzXiA=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", "d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s, o, u, a, f) {
			    "use strict";
			    var l = function(e) {
			        return f.reduce(e, function(e, t) {
			            var n = t.type;
			            return e[n] ? e[n].push(t) : e[n] = [ t ], e;
			        }, {});
			    }, c = function(e, t) {
			        for (var n in t) {
			            var r = t[n];
			            e[o(r.namespace, r.name)] = r;
			        }
			    }, h = function(e, t) {
			        t || (t = function() {});
			        var n = function(e, t) {
			            this.bundles = {}, this.eventManager = e, this.progressCallback = t, this.progress = 0, this.lastSendProgress = 0, this.progressHandler = function(e, t, n, r) {
			                this.progress += e / r;
			                var i = s.roundToResolution(this.progress, .01);
			                if (i <= this.lastSendProgress) return;
			                this.lastSendProgress = i, this.progressCallback(i);
			            };
			        };
			        return n.prototype = {
			            addBundle: function(e, t) {
			                var n = f.bind(this.progressHandler, this, t * .99);
			                this.bundles[e] = n, this.eventManager.subscribe([ u.RESOURCE_PROGRESS, e ], n);
			            },
			            complete: function() {
			                this.progressCallback(1);
			            },
			            destroy: function() {
			                var e = this.bundles, t = this.eventManager;
			                for (var n in e) {
			                    var r = e[n];
			                    t.unsubscribe([ u.RESOURCE_PROGRESS, n ], r);
			                }
			            }
			        }, new n(e, t);
			    };
			    return function(t, r, s, o) {
			        var a = t.assetManager, p = t.configurationManager, d = t.eventManager, v = t.libraryManager, m = t.resources, g = t.entityManager, y = r + "-library", b = r + "-resources", w = h(d, o);
			        w.addBundle(r, .1), w.addBundle(y, .1), w.addBundle(b, .8), d.waitFor([ u.RESOURCE_LOADING_COMPLETED, r ], function(e) {
			            c(t.scenes, e);
			        }).resume(function() {
			            d.waitFor([ u.RESOURCE_LOADING_COMPLETED, y ], function(r) {
			                var i = l(r);
			                e(a, i.asset), v.load(n(p, i.asset), {
			                    name: b,
			                    isMetaDataLoad: !1
			                }), f.each(i.component, f.bind(g.registerComponent, g)), c(t.scenes, i.scene);
			            }).and([ u.RESOURCE_LOADING_COMPLETED, b ], f.bind(a.injectResources, a)).resume(function() {
			                w.complete(), w.destroy(), d.unsubscribeAll([ u.RESOURCE_LOADING_COMPLETED, r ]), d.unsubscribeAll([ u.RESOURCE_LOADING_COMPLETED, y ]), d.unsubscribeAll([ u.RESOURCE_LOADING_COMPLETED, b ]), s();
			            });
			            var o = t.scenes[r];
			            v.load(i(o.libraryIds), {
			                name: y
			            });
			        }), v.load(i([ r ]), {
			            name: r
			        });
			    };
			}), define("OINaBjfKqIjxReAWCGJlr0Uba7I0iYH8VHNPNtHxuOA=", [ "MhHL0uYRQ50mDamX7ZC1uHXvJGt8/QI3z9dfvWa/w3g=", "h2aMiZCagVvEo7aSt+UFK1OYzb19iS+Je86Iito/sUs=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n) {
			    "use strict";
			    var r = function(e, r, i, s, o, u, a) {
			        var f = e.scenes[u];
			        if (!f) throw 'Error: Could not find scene configuration for scene "' + u + '".';
			        var l = new t(e, r, i, s, o, f, a);
			        l.init(), this.mainLoop.setRenderCallback(n.bind(l.render, l)), this.mainLoop.setUpdateCallback(n.bind(l.update, l)), this.activeScene = l, this.loadingPending = !1, this.processCmdQueue(), this.sendMessageToEditor && this.sendMessageToEditor("spelled.debug.application.sceneStarted", u);
			    }, i = function(t, i, s) {
			        var o = s, u = function() {
			            var u = this.spell;
			            this.activeScene && (this.mainLoop.setRenderCallback(), this.mainLoop.setUpdateCallback(), this.activeScene.destroy(), this.entityManager.init(), this.activeScene = undefined, o && !u.configurationManager.getValue("platform.hasPlentyRAM") && (u.assetManager.free(), u.libraryManager.free()), u.statisticsManager.reset());
			            var a = this.sendMessageToEditor ? n.bind(this.sendMessageToEditor, null, "spelled.loadingProgress") : undefined;
			            this.cmdQueue = [], this.loadingPending = !0;
			            var f = u.scenes[t];
			            if (f && u.libraryManager.isAvailable(f.libraryIds)) r.call(this, u, this.entityManager, this.libraryManager, this.statisticsManager, this.isModeDevelopment, t, i); else {
			                var l = u.configurationManager.getValue("loadingScene");
			                s && l ? e(u, l, n.bind(r, this, u, this.entityManager, this.libraryManager, this.statisticsManager, this.isModeDevelopment, l, {
			                    startSceneId: t,
			                    initialConfig: i
			                }), a) : e(u, t, n.bind(r, this, u, this.entityManager, this.libraryManager, this.statisticsManager, this.isModeDevelopment, t, i), a);
			            }
			        };
			        this.mainLoop.setPreNextFrame(n.bind(u, this));
			    }, s = function(e, t, n, r, i, s, o) {
			        this.activeScene, this.entityManager = t, this.mainLoop = i, this.sendMessageToEditor = s, this.spell = e, this.statisticsManager = n, this.libraryManager = r, this.isModeDevelopment = o, this.cmdQueue = [], this.loadingPending = !1;
			    };
			    return s.prototype = {
			        changeScene: function(e, t, n) {
			            this.isModeDevelopment ? this.spell.sendMessageToEditor("spelled.debug.application.startScene", {
			                startSceneId: e,
			                initialConfig: t,
			                showLoadingScene: n
			            }) : i.call(this, e, t, n);
			        },
			        startScene: i,
			        processCmdQueue: function() {
			            if (this.loadingPending) return;
			            var e = this.cmdQueue;
			            for (var t = 0; t < e.length; t++) {
			                var n = e[t];
			                this.activeScene[n.fn].apply(this.activeScene, n.args);
			            }
			            e.length = 0;
			        },
			        addSystem: function(e, t, n, r) {
			            this.cmdQueue.push({
			                fn: "addSystem",
			                args: [ e, t, n, r ]
			            }), this.processCmdQueue();
			        },
			        moveSystem: function(e, t, n, r) {
			            this.cmdQueue.push({
			                fn: "moveSystem",
			                args: [ e, t, n, r ]
			            }), this.processCmdQueue();
			        },
			        removeSystem: function(e, t) {
			            this.cmdQueue.push({
			                fn: "removeSystem",
			                args: [ e, t ]
			            }), this.processCmdQueue();
			        },
			        restartSystem: function(e, t, n) {
			            this.cmdQueue.push({
			                fn: "restartSystem",
			                args: [ e, t, n ]
			            }), this.processCmdQueue();
			        },
			        updateSystem: function(e, t, n) {
			            this.cmdQueue.push({
			                fn: "updateSystem",
			                args: [ e, t, n ]
			            }), this.processCmdQueue();
			        }
			    }, s;
			}), define("B04e4VhXopyRLZ1CJe/tBp5ZUblS2gzQCcRU/qk54rs=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function(t, n) {
			        var r = n.attributes;
			        for (var i = 0, s = r.length, o; i < s; i++) o = r[i], t[o.name] = e.clone(o["default"]);
			        return t;
			    };
			}), define("Ip+nZkdeOq37FrXp3GzfI6EqpDjAbF4/VaVssMDAUJQ=", [ "VARx5D0ga68cy8NlL0048TNzV6HQOz8e4ZC9Q2rlpD4=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t) {
			    "use strict";
			    var n = function(n, r) {
			        for (var i in r) n[i] = t.extend(n[i] || {}, e(r[i]));
			        return n;
			    };
			    return n;
			}), define("VARx5D0ga68cy8NlL0048TNzV6HQOz8e4ZC9Q2rlpD4=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function t(n) {
			        var r = e.isArray(n);
			        if (r || e.isObject(n)) {
			            var i = r ? [] : {};
			            return e.each(n, function(e, n) {
			                i[n] = t(e);
			            }), i;
			        }
			        return n;
			    };
			}), define("TpUPENVsbpktS1yxz8LZH4ftV7yQhfNp9dpn/zLcys4=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    var t = "The first argument for create must be a constructor. You passed in ";
			    return function(n, r, i) {
			        if (n.prototype === undefined) throw t + n;
			        var s = {};
			        !!i && e.isObject(i) && e.extend(s, i), s.prototype = n.prototype;
			        var o = n.apply(s, r);
			        return o || s;
			    };
			}), define("x+aoL4OeksmAAgV8+dHtcYBBr7EChbSqGxZQUUVVR4A=", function() {
			    "use strict";
			    var e = function(e, t, n) {
			        var r = e.slice((n || t) + 1 || e.length);
			        return e.length = t < 0 ? e.length + t : t, e.push.apply(e, r);
			    };
			    return e;
			}), define("kuo4CZ9KQ512nkgHgkhEQw7SM9XaLIpsYBcjXhzKG0Y=", function() {
			    "use strict";
			    return {
			        ROOT_COMPONENT_ID: "spell.component.entityComposite.root",
			        PARENT_COMPONENT_ID: "spell.component.entityComposite.parent",
			        CHILDREN_COMPONENT_ID: "spell.component.entityComposite.children",
			        METADATA_COMPONENT_ID: "spell.component.entityMetaData",
			        EVENT_HANDLERS_COMPONENT_ID: "spell.component.eventHandlers",
			        TRANSFORM_COMPONENT_ID: "spell.component.2d.transform",
			        TEXTURE_MATRIX_COMPONENT_ID: "spell.component.2d.graphics.textureMatrix",
			        CAMERA_COMPONENT_ID: "spell.component.2d.graphics.camera",
			        STATIC_APPEARANCE_COMPONENT_ID: "spell.component.2d.graphics.appearance",
			        TEXT_APPEARANCE_COMPONENT_ID: "spell.component.2d.graphics.textAppearance",
			        ANIMATED_APPEARANCE_COMPONENT_ID: "spell.component.2d.graphics.animatedAppearance",
			        QUAD_GEOMETRY_COMPONENT_ID: "spell.component.2d.graphics.geometry.quad",
			        TILEMAP_COMPONENT_ID: "spell.component.2d.graphics.tilemap",
			        PARALLAX_COMPONENT_ID: "spell.component.2d.graphics.parallax",
			        PHYSICS_BODY_COMPONENT_ID: "spell.component.physics.body",
			        PHYSICS_FIXTURE_COMPONENT_ID: "spell.component.physics.fixture",
			        PHYSICS_BOX_SHAPE_COMPONENT_ID: "spell.component.physics.shape.box",
			        PHYSICS_CIRCLE_SHAPE_COMPONENT_ID: "spell.component.physics.shape.circle",
			        PHYSICS_CONVEX_POLYGON_SHAPE_COMPONENT_ID: "spell.component.physics.shape.convexPolygon",
			        PHYSICS_JNRPLAYER_SHAPE_COMPONENT_ID: "spell.component.physics.shape.jumpAndRunPlayer",
			        KEY_FRAME_ANIMATION_COMPONENT_ID: "spell.component.animation.keyFrameAnimation",
			        SOUND_EMITTER_COMPONENT_ID: "spell.component.audio.soundEmitter",
			        VISUAL_OBJECT_COMPONENT_ID: "spell.component.visualObject",
			        CONTROLLABLE_COMPONENT_ID: "spell.component.controllable"
			    };
			}), define("pzW6zJkIpKONYaZfQ3DLzd3v+2inNEBdcFLJQpiZpEw=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    var t = function(e, n) {
			        var r = e.length, i;
			        for (var s = 0; s < r; s++) {
			            var o = e[s];
			            i = n(o);
			            if (i) return i;
			            var u = o.children;
			            if (u && u.length > 0) return t(u, n);
			        }
			    };
			    return function(n, r) {
			        var i = e.isArray(n) ? n : [ n ];
			        return t(i, r);
			    };
			}), define("dXBfcPX/k2r8hX6RIGFi+TdKQKneuUJZCdF4LCs94T4=", function() {
			    "use strict";
			    return function(e) {
			        var t = e.children;
			        if (!t) return !1;
			        var n = {};
			        for (var r = 0, i = t.length; r < i; r++) {
			            var s = t[r].name;
			            if (s) {
			                if (!!n[s]) return s;
			                n[s] = !0;
			            }
			        }
			        return !1;
			    };
			}), define("PbOCcvOCWKv40wXBycm4YMYdhAZoomihBhjVpxWEQTk=", [ "dXBfcPX/k2r8hX6RIGFi+TdKQKneuUJZCdF4LCs94T4=", "pzW6zJkIpKONYaZfQ3DLzd3v+2inNEBdcFLJQpiZpEw=", "DL2XO5bR2mezFB5wDHhPp+WUMECQNrIMAg+5DYokByc=", "kuo4CZ9KQ512nkgHgkhEQw7SM9XaLIpsYBcjXhzKG0Y=", "x+aoL4OeksmAAgV8+dHtcYBBr7EChbSqGxZQUUVVR4A=", "TpUPENVsbpktS1yxz8LZH4ftV7yQhfNp9dpn/zLcys4=", "d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", "v8fOdhNCtMEZStOrNxspT+wYpcqnI29sSZZku+1iaIw=", "VARx5D0ga68cy8NlL0048TNzV6HQOz8e4ZC9Q2rlpD4=", "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "Ip+nZkdeOq37FrXp3GzfI6EqpDjAbF4/VaVssMDAUJQ=", "hJb+mSFyVabGetH1ke8dX63PPYPjsoFy4ea4w/GvIxQ=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "B04e4VhXopyRLZ1CJe/tBp5ZUblS2gzQCcRU/qk54rs=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", "yVWG+StUPY2cpL5TJDIz/GlQdjOt3yQROd6W8z+bGks=", "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s, o, u, a, f, l, c, h, p, d, v, m, g) {
			    "use strict";
			    var y = 1, b = h.createComponentType, w = r.ROOT_COMPONENT_ID, E = r.CHILDREN_COMPONENT_ID, S = r.PARENT_COMPONENT_ID, x = r.METADATA_COMPONENT_ID, T = r.TRANSFORM_COMPONENT_ID, N = r.TEXTURE_MATRIX_COMPONENT_ID, C = r.EVENT_HANDLERS_COMPONENT_ID, k = r.STATIC_APPEARANCE_COMPONENT_ID, L = r.ANIMATED_APPEARANCE_COMPONENT_ID, A = r.QUAD_GEOMETRY_COMPONENT_ID, O = r.TILEMAP_COMPONENT_ID, M = r.VISUAL_OBJECT_COMPONENT_ID, _ = function(e) {
			        var t = g.reduce(e.attributes, function(e, t) {
			            var n = t.name;
			            return e[n] = e[n] ? e[n] + 1 : 1, e;
			        }, {});
			        return !g.any(t, function(e) {
			            return e > 1;
			        });
			    }, D = function(e) {
			        if (!e) return "" + y++;
			        var t = parseInt(e);
			        return g.isNaN(t) ? e : (y = Math.max(t + 1, y), "" + t);
			    }, P = function(e, t, n, r, i) {
			        var s = e[T], o = s[i];
			        if (!o) return;
			        var u = e[S], a = e[E], f = a[i], l = i, c = o.localMatrix, h = o.worldMatrix, p, d;
			        v.identity(c), v.translate(c, c, o.translation), v.rotate(c, c, o.rotation), v.scale(c, c, o.scale);
			        while (p = u[l]) {
			            l = p.id;
			            var m = s[l];
			            if (m) {
			                d = m.worldMatrix;
			                break;
			            }
			        }
			        d ? v.multiply(h, d, c) : v.copy(h, c), o.worldTranslation[0] = h[6], o.worldTranslation[1] = h[7], r && $(n, e, i);
			        if (f) {
			            var g = f.ids;
			            for (var y = 0, b = g.length; y < b; y++) P(e, t, n, r, g[y]);
			        }
			    }, H = function(e) {
			        var t = e.matrix, n = e.translation, r = e.scale;
			        v.identity(t), v.translate(t, t, n), v.scale(t, t, r), e.isIdentity = n[0] === 0 && n[1] === 0 && r[0] === 1 && r[1] === 1;
			    }, B = function(e, t, n, r) {
			        var i = t[r], s = 1;
			        i && (s = i.opacity * n, i.worldOpacity = s);
			        var o = e[r];
			        if (o) {
			            var u = o.ids;
			            for (var a = 0, f = u.length; a < f; a++) B(e, t, s, u[a]);
			        }
			    }, j = function(e, t) {
			        var n = e[S][t], r = e[M], i = 1;
			        if (n) {
			            var s = r[n.id];
			            s && (i = s.worldOpacity);
			        }
			        B(e[E], r, i, t);
			    }, F = function(e, t, n, r) {
			        var i;
			        for (var s in r) {
			            i = r[s];
			            if (e[s][n]) throw "Error: Adding a component to the entity with id '" + n + "' failed because the entity already has a component named '" + s + "'. Check with hasComponent first if this entity already has this component.";
			            e[s][n] = i;
			        }
			        for (var s in r) i = r[s], t.publish([ f.COMPONENT_CREATED, s ], [ i, n ]);
			    }, I = function(e, t) {
			        for (var n in e) {
			            var r = e[n];
			            if (r[t]) return !0;
			        }
			        return !1;
			    }, q = function(e, t, n, r, i) {
			        var s = t[E][r], o = t[S][r], u = !0;
			        if (o) {
			            var a = t[E][o.id];
			            if (a) {
			                var l = a.ids;
			                l.splice(l.indexOf(r), 1);
			            }
			        }
			        if (i) delete t[i][r], I(t, r) && (u = !1), i === M && n.remove(r); else {
			            var c = !!t[M][r];
			            for (var h in t) {
			                var p = t[h];
			                p[r] && delete p[r];
			            }
			            c && n.remove(r);
			        }
			        if (u) {
			            e.publish(f.ENTITY_DESTROYED, r);
			            if (s) {
			                var d = s.ids;
			                for (var v = 0, m = d.length; v < m; v++) q(e, t, n, d[v]);
			            }
			        }
			    }, R = function(e, t) {
			        return g.reduce(t, function(e, t) {
			            var n = g.find(e, function(e) {
			                return t.name === e.name;
			            });
			            return n ? (n.children = U(n.children, t.children), n.id = t.id, l(n.config, t.config)) : e.push(t), e;
			        }, a(e));
			    }, U = function(e, t) {
			        if (!t || t.length === 0) return t;
			        if (!e || e.length === 0) return t;
			        var n = a(e);
			        for (var r = 0; r < n.length; r++) {
			            var i = n[r], s = g.find(t, function(e) {
			                return e.name === i.name;
			            });
			            if (!s) continue;
			            l(i.config, s.config), s.id && (i.id = s.id);
			        }
			        return n;
			    }, z = function(e, t, n) {
			        var r = e[S], i = e[E], s = i[n];
			        s && s.ids.push(t), r[t] = {
			            id: n
			        };
			    }, W = function(e, t, n) {
			        for (var r in e) {
			            var s = e[r], o = g.indexOf(s.ids, t);
			            if (o !== -1) {
			                i(s.ids, o);
			                break;
			            }
			        }
			    }, X = function(e, t, n) {
			        if (t === n) return;
			        var r = e[w], i = e[E], s = !!r[t];
			        if (s && !n) return;
			        n && (W(i, t, n), z(e, t, n), s && delete r[t]), !s && !n && (r[t] = {}, W(i, t, n));
			    }, V = function(e, t, n, r) {
			        var i = t[M][r];
			        if (!i || i.pass === "ui" || i.pass === "background") return;
			        var s = t[E][r], o = t[S][r], u = t[T][r];
			        e.insert(u.worldTranslation, n, {
			            id: r,
			            parent: o ? o.id : 0,
			            children: s ? s.ids : undefined,
			            layer: i ? i.layer : 0
			        }, r);
			    }, $ = function(e, t, n) {
			        e.remove(n), V(e, t, ot(t, n), n);
			    }, J = function(n, r) {
			        if (!r) return;
			        var i = g.isString(r) ? r : r.entityTemplateId, s = {
			            children: r.children || [],
			            config: r.config || {},
			            id: r.id ? r.id : undefined,
			            parentId: r.parentId,
			            name: r.name || "",
			            entityTemplateId: i
			        }, o = t(s, e);
			        if (o) throw 'Error: The entity configuration contains the ambiguous sibling name "' + o + '". Entity siblings must have unique names.';
			        if (i) {
			            var u = n.getByLibraryId(i);
			            if (!u) throw "Error: Unknown entity template '" + i + "'. Could not create entity.";
			            s.children = R(u.children, s.children);
			        }
			        return s;
			    }, K = function(e, t, n, r, i) {
			        return t && !n && (e[w] = {}), n && (e[S] = {
			            id: n
			        }), e[x] = {
			            name: r,
			            entityTemplateId: i
			        }, e;
			    }, Q = function(e, t, n, r) {
			        var i = e[x];
			        for (var s = 0, o, u = t.length; s < u; s++) {
			            o = t[s];
			            if (n != o && i[o].name === r) return !0;
			        }
			        return !1;
			    }, G = function(e, t, n, r) {
			        var i = b(t, e, r);
			        return p(i || {}, n);
			    }, Y = function(e, t) {
			        return t === undefined ? e : g.extend(e, t);
			    }, Z = function(e) {
			        return !!g.find(e, function(e) {
			            var t = e.type;
			            return g.isString(t) ? e.type.indexOf("assetId:") === 0 : !1;
			        });
			    }, et = function(e, t, n) {
			        var r = n.assetId;
			        if (!r) return;
			        var i = e.get(r);
			        if (!i && c.startsWith(r, "script:")) {
			            var s = r.substr(7);
			            i = t.require(u(s));
			        }
			        if (!i) throw "Error: Could not resolve asset id '" + r + "' to asset instance. Please make sure that the asset id is valid.";
			        return n.asset = i, n;
			    }, tt = function(e, t, n, r, i, s, o, u) {
			        u === undefined && (u = !0);
			        var f = l(o ? a(o.config) : {}, i);
			        return g.each(f, function(i, o) {
			            var a = n.getByLibraryId(o);
			            if (!a) throw 'Error: Could not find component definition "' + o + s ? '" referenced in entity template "' + s + '".' : '".';
			            var l = Y(G(e, r, a, o), i);
			            f[o] = Z(a.attributes) && u ? et(t, r, l) : l;
			        }), f;
			    }, nt = function(e, t, n, r, i, s) {
			        var o = i ? n.getByLibraryId(i) : undefined;
			        return tt(e, t, n, r, s, i, o);
			    }, rt = function(e, t, n, r, i, s, o, u, a) {
			        u = J(r, u);
			        if (!u) throw "Error: Supplied invalid arguments.";
			        var l = u.entityTemplateId, c = u.config || {}, h = u.parentId;
			        if (!l && !c) throw "Error: Supplied invalid arguments.";
			        a = a === !0 || a === undefined && !h;
			        var p = D(u.id);
			        K(c, a, h, u.name, l);
			        var d = nt(e, t, r, i, l, c || {});
			        F(s, n, p, d), P(s, n, o, !1, p);
			        var v = s[N][p];
			        v && H(v);
			        var m = g.map(u.children, function(u) {
			            return u.parentId = p, rt(e, t, n, r, i, s, o, u, !1);
			        }), y = {};
			        y[E] = {
			            ids: m
			        }, F(s, n, p, y);
			        if (u.name) {
			            var b;
			            if (a) b = g.keys(s[w]); else {
			                var S = s[E][h];
			                S && (b = S.ids);
			            }
			            if (b && Q(s, b, p, u.name)) throw 'Error: The name "' + u.name + '" of entity ' + p + " collides with one if its siblings. Entity siblings must have unique names.";
			        }
			        return V(o, s, ot(s, p), p), g.extend(d, y), n.publish(f.ENTITY_CREATED, [ p, d ]), p;
			    }, it = function(e, t) {
			        return g.reduce(e, function(e, n, r) {
			            var i = n[t];
			            return i && (e[r] = i), e;
			        }, {});
			    }, st = function(e, t, n) {
			        var r = e[t], i = r ? r.ids : [];
			        for (var s = 0, o = i.length; s < o; s++) st(e, i[s], n);
			        return n.push(t), n;
			    }, ot = function(e, t) {
			        var n = e[k], r = e[L], i = e[T], s = e[A], o = e[O], u = m.create();
			        if (s && s[t] && s[t].dimensions) m.copy(u, s[t].dimensions); else if (n && n[t] && n[t].asset && n[t].asset.resource && n[t].asset.resource.dimensions) m.copy(u, n[t].asset.resource.dimensions); else if (r && r[t] && r[t].asset && r[t].asset.frameDimensions) m.copy(u, r[t].asset.frameDimensions); else {
			            if (!(o && o[t] && o[t].asset)) return;
			            m.copy(u, o[t].asset.tilemapDimensions), m.multiply(u, u, o[t].asset.spriteSheet.frameDimensions);
			        }
			        return i && i[t], u;
			    }, ut = function(e, t, n) {
			        g.isObject(n) || g.isArray(n) ? g.extend(e[t], n) : e[t] = n;
			    }, at = function(e, t, n, r, i, s, o) {
			        ut(s, i, o);
			        if (n[r]) {
			            var u = i === "assetId";
			            u && et(e, t, s);
			        }
			    }, ft = function(e, t, n, r, i, s) {
			        for (var o in s) ut(i, o, s[o]);
			        if (n[r]) {
			            var u = !!s.assetId;
			            u && et(e, t, i);
			        }
			    }, lt = function(e, t, n, r, i, s) {
			        this.configurationManager = t, this.componentMaps = {}, this.assetManager = n, this.eventManager = r, this.libraryManager = i, this.moduleLoader = s, this.spell = e, this.spatialIndex = undefined, this.componentsWithAssets = {};
			    };
			    return lt.prototype = {
			        createEntity: function(e) {
			            var t = rt(this.spell, this.assetManager, this.eventManager, this.libraryManager, this.moduleLoader, this.componentMaps, this.spatialIndex, e);
			            j(this.componentMaps, t);
			            var n = this.componentMaps[S][t];
			            if (n) {
			                var r = n.id, i = this.componentMaps[E], s = i[r];
			                s ? (s.ids.push(t), this.eventManager.publish([ f.COMPONENT_UPDATED, E ], [ s, t ])) : (s = {
			                    ids: [ t ]
			                }, i[r] = s, this.eventManager.publish([ f.COMPONENT_CREATED, E ], [ s, t ]));
			            }
			            return t;
			        },
			        createEntities: function(e) {
			            for (var t = 0, n = e.length; t < n; t++) this.createEntity(e[t]);
			        },
			        removeEntity: function(e) {
			            return e ? (q(this.eventManager, this.componentMaps, this.spatialIndex, e), !0) : !1;
			        },
			        getEntityById: function(e) {
			            return it(this.componentMaps, e);
			        },
			        cloneEntity: function(e) {
			            var t = {
			                config: it(this.componentMaps, e)
			            };
			            return rt(this.spell, this.assetManager, this.eventManager, this.libraryManager, this.moduleLoader, this.componentMaps, this.spatialIndex, t);
			        },
			        getEntityDimensions: function(e) {
			            return ot(this.componentMaps, e);
			        },
			        getEntityIdsByName: function(e, t) {
			            var n = this.componentMaps[x], r = [], i = t ? st(this.componentMaps[E], t, []) : g.keys(n);
			            for (var s = 0, o = i.length; s < o; s++) {
			                var u = i[s];
			                n[u] && n[u].name === e && r.push(u);
			            }
			            return r;
			        },
			        getEntitiesByName: function(e) {
			            var t = this.getEntityIdsByName(e, undefined), n = {};
			            for (var r = 0, i = t.length; r < i; r++) {
			                var s = t[r];
			                n[s] = this.getEntityById(s);
			            }
			            return n;
			        },
			        getEntityIdsByRegion: function(e, t) {
			            return this.spatialIndex.search(e, t);
			        },
			        init: function() {
			            var e = this.componentMaps, t = this.eventManager, r = this.spatialIndex;
			            for (var i in e) {
			                var s = e[i];
			                for (var o in s) q(t, e, r, o);
			                e[i] = {};
			            }
			            this.spatialIndex = new n(this.configurationManager.getValue("quadTreeSize"));
			        },
			        reassignEntity: function(e, t) {
			            if (!e) throw "Error: Missing entity id.";
			            X(this.componentMaps, e, t);
			        },
			        hasComponent: function(e, t) {
			            var n = this.componentMaps[t];
			            return n ? !!n[e] : !1;
			        },
			        addComponent: function(e, t, n) {
			            if (!e) throw "Error: Missing entity id.";
			            if (!t) throw "Error: Missing component id.";
			            var r = {};
			            r[t] = n || {}, F(this.componentMaps, this.eventManager, e, nt(this.spell, this.assetManager, this.libraryManager, this.moduleLoader, null, r));
			        },
			        removeComponent: function(e, t) {
			            if (!e) throw "Error: Missing entity id.";
			            q(this.eventManager, this.componentMaps, this.spatialIndex, e, t);
			        },
			        getComponentById: function(e, t) {
			            var n = this.componentMaps[t];
			            return n ? n[e] : undefined;
			        },
			        getComponentsByName: function(e, t, n) {
			            var r = this.getComponentMapById(e), i = this.getEntityIdsByName(t, n);
			            return i.length === 0 || !r ? [] : g.pick(r, i);
			        },
			        updateComponent: function(e, t, n) {
			            var r = this.getComponentById(e, t);
			            return r ? (ft(this.assetManager, this.moduleLoader, this.componentsWithAssets, t, r, n), t === T ? (n.translation || n.scale || n.rotation !== undefined) && P(this.componentMaps, this.eventManager, this.spatialIndex, !0, e) : t === N ? (n.translation || n.scale || n.rotation) && H(this.componentMaps[N][e]) : t === M && ($(this.spatialIndex, this.componentMaps, e), j(this.componentMaps, e)), this.eventManager.publish([ f.COMPONENT_UPDATED, t ], [ r, e ]), !0) : !1;
			        },
			        updateComponentAttribute: function(e, t, n, r) {
			            var i = this.getComponentById(e, t);
			            if (!i) return !1;
			            var s = i[n];
			            return s === undefined ? !1 : (at(this.assetManager, this.moduleLoader, this.componentsWithAssets, t, n, i, r), t === T ? (n === "translation" || n === "scale" || n === "rotation") && P(this.componentMaps, this.eventManager, this.spatialIndex, !0, e) : t === N ? (n === "translation" || n === "scale" || n === "rotation") && H(this.componentMaps[N][e]) : t === M && ($(this.spatialIndex, this.componentMaps, e), j(this.componentMaps, e)), this.eventManager.publish([ f.COMPONENT_UPDATED, t ], [ i, e ]), !0);
			        },
			        getComponentMapById: function(e) {
			            return this.componentMaps[e];
			        },
			        updateWorldTransform: function(e) {
			            P(this.componentMaps, this.eventManager, this.spatialIndex, !0, e);
			        },
			        updateTextureMatrix: function(e) {
			            H(this.componentMaps[N][e]);
			        },
			        updateAssetReferences: function(e, t) {
			            var n = this.componentMaps;
			            for (var r in this.componentsWithAssets) {
			                var i = n[r];
			                for (var s in i) {
			                    var o = i[s];
			                    o.assetId === e && (o.asset = t);
			                }
			            }
			        },
			        refreshAssetReferences: function(e) {
			            var t = this.componentMaps;
			            for (var n in this.componentsWithAssets) {
			                var r = t[n];
			                for (var i in r) {
			                    var s = r[i];
			                    if (s.assetId.slice(0, s.assetId.indexOf(":")) === "script") continue;
			                    s.asset = e.get(s.assetId);
			                }
			            }
			        },
			        triggerEvent: function(e, t, n) {
			            var r = this.componentMaps[C][e];
			            if (!r) return;
			            var i = r.asset[t];
			            if (!i) return;
			            i.apply(null, [ this.spell, e ].concat(n));
			        },
			        updateEntityTemplate: function(e) {
			            var t = o(e.namespace, e.name), n = g.reduce(this.componentMaps[x], function(e, n, r) {
			                return n.entityTemplateId === t && e.push(r), e;
			            }, []);
			            for (var r = 0, i, s = n.length; r < s; r++) i = n[r], this.removeEntity(i), this.spatialIndex.remove(i), this.createEntity({
			                entityTemplateId: t,
			                id: i
			            });
			        },
			        registerComponent: function(e) {
			            var t = o(e.namespace, e.name);
			            if (!_(e)) throw 'Error: The format of the supplied component definition "' + t + '" is invalid.';
			            this.componentMaps[t] || (this.componentMaps[t] = {}), Z(e.attributes) ? this.componentsWithAssets[t] = !0 : delete this.componentsWithAssets[t];
			        }
			    }, lt;
			}), define("/V8x6jYt/KxKsfIudrdXKJHn0YsD2VYx5hYPCYv9N6g=", [ "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n) {
			    "use strict";
			    var r = t.Time.getCurrentInMs, i = function(t, i, s) {
			        this.newRemoteTime = s, this.remoteTime = s, this.newRemoteTimPending = !1, this.localTime = s, this.previousSystemTime = r(), this.elapsedTime = 0, this.deltaLocalRemoteTime = 0, this.statisticsManager = i, t.subscribe([ "clockSyncUpdate" ], n.bind(function(e) {
			            this.newRemoteTime = e, this.newRemoteTimPending = !0;
			        }, this)), t.subscribe(e.CLOCK_SYNC_ESTABLISHED, n.bind(function(e) {
			            this.newRemoteTime = this.remoteTime = this.localTime = e, this.newRemoteTimPending = !1;
			        }, this));
			    };
			    return i.prototype = {
			        update: function() {
			            this.newRemoteTimPending && (this.remoteTime = this.newRemoteTime, this.newRemoteTimPending = !1);
			            var e = r();
			            this.elapsedTime = Math.max(e - this.previousSystemTime, 0), this.previousSystemTime = e, this.localTime += this.elapsedTime, this.remoteTime += this.elapsedTime, this.deltaLocalRemoteTime = this.localTime - this.remoteTime;
			            var t = 1e9;
			            this.relativeClockSkew = (this.localTime / this.remoteTime * t - t) * 2 + 1;
			        },
			        getLocalTime: function() {
			            return this.localTime;
			        },
			        getElapsedTime: function() {
			            return this.elapsedTime;
			        },
			        getRemoteTime: function() {
			            return this.remoteTime;
			        }
			    }, i;
			}), define("RHForCY775HrCxRbFeVX9Spz8YmenJsOpg1HHlNx44o=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=" ], function(e) {
			    "use strict";
			    var t = e.Time.getCurrentInMs, n = function() {
			        this.value = 0;
			    };
			    return n.prototype = {
			        start: function() {
			            this.value = t();
			        },
			        stop: function() {
			            return t() - this.value;
			        }
			    }, n;
			}), define("xzulUmNYw/38rNcu3Y7xU3DRAD5hGCLMNWsYeDxH4jc=", function() {
			    "use strict";
			    var e = function(t, n) {
			        var r = t.children;
			        if (t.id === n) return t;
			        for (var i = 0, s = r.length; i < s; i++) {
			            var o = e(r[i], n);
			            if (o) return o;
			        }
			    }, t = function(t, n, r) {
			        var i = e(t, n);
			        return i ? (i.children.push(r), !0) : !1;
			    }, n = function(e, t, r) {
			        if (!e) return;
			        r || (r = 0), t(e, r);
			        var i = e.children;
			        for (var s = 0, o = i.length, u = r + 1; s < o; s++) n(i[s], t, u);
			    };
			    return {
			        addNode: t,
			        getNode: e,
			        eachNode: n
			    };
			}), define("7PhHlzIXiau/l87zhE3bIdhsPohgmy+yJQROuFXc0Uw=", [ "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "xzulUmNYw/38rNcu3Y7xU3DRAD5hGCLMNWsYeDxH4jc=", "RHForCY775HrCxRbFeVX9Spz8YmenJsOpg1HHlNx44o=", "/V8x6jYt/KxKsfIudrdXKJHn0YsD2VYx5hYPCYv9N6g=", "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s, o) {
			    "use strict";
			    var u = 32, a = 100, f = 1e3, l = t.eachNode, c = function(e) {
			        var t = "";
			        while (e--) t += " ";
			        return t;
			    }, h = function(e) {
			        var t = "";
			        return l(e, function(e, n) {
			            var r = e.metrics;
			            t += c(n) + e.id + ": " + r[0] + "/" + r[1] + "/" + r[2] + "/" + r[3] + "\n";
			        }), t;
			    }, p = function(e, t, s) {
			        this.updateIntervalInMs = s || u, this.render = null, this.update = null, this.preNextFrame = [], this.accumulatedTimeInMs = this.updateIntervalInMs;
			        var o = i.Time.getCurrentInMs();
			        this.timer = new r(e, t, o), this.timeSinceLastPerfPrintInMs = 0, this.statisticsManager = t, this.stopWatch = new n, this.totalStopWatch = new n;
			    };
			    return p.prototype = {
			        setRenderCallback: function(e) {
			            this.render = e;
			        },
			        setUpdateCallback: function(e) {
			            this.update = e;
			        },
			        setPreNextFrame: function(e) {
			            this.preNextFrame.push(e);
			        },
			        callEveryFrame: function(e) {
			            this.preNextFrame.length > 0 && this.preNextFrame.pop()();
			            var t = this.statisticsManager, n = this.timer;
			            n.update();
			            var r = this.updateIntervalInMs, i = n.getLocalTime(), o = Math.min(n.getElapsedTime(), a);
			            this.totalStopWatch.start(), t.startTick(i, o);
			            if (this.update) {
			                this.stopWatch.start();
			                var u = this.accumulatedTimeInMs + o;
			                while (u >= r) this.update(i, r), u -= r;
			                this.accumulatedTimeInMs = u, t.updateNode("update", this.stopWatch.stop());
			            }
			            this.render && (this.stopWatch.start(), this.render(i, o), t.updateNode("render", this.stopWatch.stop())), t.updateNode("total", this.totalStopWatch.stop()), this.timeSinceLastPerfPrintInMs > f && (this.timeSinceLastPerfPrintInMs -= f), this.timeSinceLastPerfPrintInMs += o, s.callNextFrame(this.callEveryFramePartial);
			        },
			        run: function() {
			            this.callEveryFramePartial = o.bind(this.callEveryFrame, this), this.callEveryFramePartial(i.Time.getCurrentInMs());
			        }
			    }, function(e, t, n) {
			        return new p(e, t, n);
			    };
			}), define("/onvXG9VhyKIuG0Hn1bR4/mu3mvWKrL3S9G1yf5s9Bs=", [ "yVWG+StUPY2cpL5TJDIz/GlQdjOt3yQROd6W8z+bGks=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=", "UXTIupZGRczsgnUj2SpAlCuuFJw3p3TtznLNsAamIcQ=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=" ], function(e, t, n, r, i) {
			    "use strict";
			    var s = function(e) {
			        var t = e.length / 4, n = new Array(t * 3);
			        for (var r = 0, i, s, o = t; r < o; r++) i = r * 4, s = r * 3, n[s] = e[i], n[s + 1] = e[i + 1], n[s + 2] = e[i + 2];
			        return n;
			    };
			    return function(s, o) {
			        var u = i.createSplashScreenImage();
			        if (u) {
			            var a = s.renderingContext.createTexture(u), f = s.configurationManager.getValue("currentScreenSize"), l = n.fromValues(Math.round(f[0] * .5 - a.dimensions[0] * .5), Math.round(f[1] * .5 - a.dimensions[1] * .5)), c = s.renderingContext, h = e.create(), p = r.fromValues(0, 0, 0, 1);
			            t.mat3Ortho(h, 0, f[0], 0, f[1]), c.setViewMatrix(h), c.setClearColor(p), c.resizeColorBuffer(f[0], f[1]), c.viewport(0, 0, f[0], f[1]), c.drawTexture(a, l, a.dimensions, null), i.registerTimer(o, 3e3);
			        } else o();
			    };
			}), define("hJb+mSFyVabGetH1ke8dX63PPYPjsoFy4ea4w/GvIxQ=", function() {
			    "use strict";
			    var e = {};
			    return e.startsWith = function(e, t) {
			        return t === "" ? !0 : !e || !t ? !1 : String(e).lastIndexOf(String(t), 0) === 0;
			    }, e;
			}), define("Vsylc/NMToQHW836UwRyCRPN84V2NddLsPHwdwldHCE=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    var t = function(n, r) {
			        for (var i in n) {
			            var s = n[i];
			            e.isObject(s) ? t(s, r) : r(s, i);
			        }
			    }, n = function(e, n, r) {
			        var i = function(e, t) {
			            r = n(r, e, t);
			        };
			        return t(e, i), r;
			    }, r = function(n, r) {
			        var i = [];
			        return t(n, function(t, n) {
			            if (!e.contains(r, t)) return;
			            i.push(n);
			        }), i;
			    };
			    return {
			        pluck: r,
			        reduce: n,
			        walk: t
			    };
			}), define("owrVs8KGmm2PtYD3Fz1K/d+hxfz6awWt4m8yvrgInPg=", function() {
			    "use strict";
			    return function(e, t, n) {
			        var r = e[0], i = e[1], s = r / i;
			        return t >= s ? r = t * i : i = r / t, n && (r = Math.round(r), i = Math.round(i)), [ r, i ];
			    };
			}), define("RtIYVMl7NLjPEVfGOmP5fh9Nx6lTDT9M9H4kPYDCldY=", [ "owrVs8KGmm2PtYD3Fz1K/d+hxfz6awWt4m8yvrgInPg=", "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=" ], function(e, t) {
			    "use strict";
			    return function(n, r, i, s) {
			        var o = t.fromValues(n, r);
			        return t.multiply(o, i, e(o, s));
			    };
			}), define("vV8JUbcAFKwRw0kj9C+z03trX9WutPyp4SJONZGPilU=", [ "rvasITs2FBDcIVclbnPocpNbQvHuu/vr/WHZ0WRVg5s=" ], function(e) {
			    "use strict";
			    return function(t, n, r, i) {
			        if (!r) return;
			        var s = t.get(e(r));
			        if (!s) return;
			        var o = s.config[i];
			        if (!o) return;
			        return o[n];
			    };
			}), define("2JM90K4OxW6bfbnvH9gYnm0kSJxaAvTFlf59uaLcTnY=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function(t, n, r) {
			        return e.isArray(n) || (n = [ n ]), function() {
			            var i = e.keys(t), s = i.length;
			            for (var o = 0; o < s; o++) {
			                var u = i[o], a = [ t[u] ], f = n.length, l = arguments ? e.toArray(arguments).concat(a) : [ a ];
			                for (var c = 0; c < f; c++) l.push(n[c][u]);
			                r.apply(null, l);
			            }
			        };
			    };
			}), define("qK33jL/Mq7B5Vu6fbGS3/sPc0C/aQisKbAMhYhm3OJk=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    var t = function(e) {
			        return e < 1 ? 0 : 1;
			    }, n = {
			        None: t,
			        Linear: e.identity,
			        QuadraticIn: function(e) {
			            return e * e;
			        },
			        QuadraticOut: function(e) {
			            return e * (2 - e);
			        },
			        QuadraticInOut: function(e) {
			            return (e *= 2) < 1 ? .5 * e * e : -.5 * (--e * (e - 2) - 1);
			        },
			        CubicIn: function(e) {
			            return e * e * e;
			        },
			        CubicOut: function(e) {
			            return --e * e * e + 1;
			        },
			        CubicInOut: function(e) {
			            return (e *= 2) < 1 ? .5 * e * e * e : .5 * ((e -= 2) * e * e + 2);
			        },
			        QuarticIn: function(e) {
			            return e * e * e * e;
			        },
			        QuarticOut: function(e) {
			            return 1 - --e * e * e * e;
			        },
			        QuarticInOut: function(e) {
			            return (e *= 2) < 1 ? .5 * e * e * e * e : -.5 * ((e -= 2) * e * e * e - 2);
			        },
			        QuinticIn: function(e) {
			            return e * e * e * e * e;
			        },
			        QuinticOut: function(e) {
			            return --e * e * e * e * e + 1;
			        },
			        QuinticInOut: function(e) {
			            return (e *= 2) < 1 ? .5 * e * e * e * e * e : .5 * ((e -= 2) * e * e * e * e + 2);
			        },
			        SinusoidalIn: function(e) {
			            return 1 - Math.cos(e * Math.PI / 2);
			        },
			        SinusoidalOut: function(e) {
			            return Math.sin(e * Math.PI / 2);
			        },
			        SinusoidalInOut: function(e) {
			            return .5 * (1 - Math.cos(Math.PI * e));
			        },
			        ExponentialIn: function(e) {
			            return e === 0 ? 0 : Math.pow(1024, e - 1);
			        },
			        ExponentialOut: function(e) {
			            return e === 1 ? 1 : 1 - Math.pow(2, -10 * e);
			        },
			        ExponentialInOut: function(e) {
			            return e === 0 ? 0 : e === 1 ? 1 : (e *= 2) < 1 ? .5 * Math.pow(1024, e - 1) : .5 * (-Math.pow(2, -10 * (e - 1)) + 2);
			        },
			        CircularIn: function(e) {
			            return 1 - Math.sqrt(1 - e * e);
			        },
			        CircularOut: function(e) {
			            return Math.sqrt(1 - --e * e);
			        },
			        CircularInOut: function(e) {
			            return (e *= 2) < 1 ? -.5 * (Math.sqrt(1 - e * e) - 1) : .5 * (Math.sqrt(1 - (e -= 2) * e) + 1);
			        },
			        ElasticIn: function(e) {
			            var t, n = .1, r = .4;
			            return e === 0 ? 0 : e === 1 ? 1 : (!n || n < 1 ? (n = 1, t = r / 4) : t = r * Math.asin(1 / n) / (2 * Math.PI), -(n * Math.pow(2, 10 * (e -= 1)) * Math.sin((e - t) * 2 * Math.PI / r)));
			        },
			        ElasticOut: function(e) {
			            var t, n = .1, r = .4;
			            return e === 0 ? 0 : e === 1 ? 1 : (!n || n < 1 ? (n = 1, t = r / 4) : t = r * Math.asin(1 / n) / (2 * Math.PI), n * Math.pow(2, -10 * e) * Math.sin((e - t) * 2 * Math.PI / r) + 1);
			        },
			        ElasticInOut: function(e) {
			            var t, n = .1, r = .4;
			            return e === 0 ? 0 : e === 1 ? 1 : (!n || n < 1 ? (n = 1, t = r / 4) : t = r * Math.asin(1 / n) / (2 * Math.PI), (e *= 2) < 1 ? -.5 * n * Math.pow(2, 10 * (e -= 1)) * Math.sin((e - t) * 2 * Math.PI / r) : n * Math.pow(2, -10 * (e -= 1)) * Math.sin((e - t) * 2 * Math.PI / r) * .5 + 1);
			        },
			        BackIn: function(e) {
			            var t = 1.70158;
			            return e * e * ((t + 1) * e - t);
			        },
			        BackOut: function(e) {
			            var t = 1.70158;
			            return --e * e * ((t + 1) * e + t) + 1;
			        },
			        BackInOut: function(e) {
			            var t = 2.5949095;
			            return (e *= 2) < 1 ? .5 * e * e * ((t + 1) * e - t) : .5 * ((e -= 2) * e * ((t + 1) * e + t) + 2);
			        },
			        BounceIn: function(e) {
			            return 1 - n.BounceOut(1 - e);
			        },
			        BounceOut: function(e) {
			            return e < 1 / 2.75 ? 7.5625 * e * e : e < 2 / 2.75 ? 7.5625 * (e -= 1.5 / 2.75) * e + .75 : e < 2.5 / 2.75 ? 7.5625 * (e -= 2.25 / 2.75) * e + .9375 : 7.5625 * (e -= 2.625 / 2.75) * e + .984375;
			        },
			        BounceInOut: function(e) {
			            return e < .5 ? n.BounceIn(e * 2) * .5 : n.BounceOut(e * 2 - 1) * .5 + .5;
			        }
			    };
			    return n;
			}), define("AE4JV5gWwq3FE9WsQybF29eg05JxvOqTmiHIZrNKCR0=", function() {
			    "use strict";
			    var e = function() {};
			    return e.generate = function() {
			        var t = e._gri, n = e._ha;
			        return n(t(32), 8) + "-" + n(t(16), 4) + "-" + n(16384 | t(12), 4) + "-" + n(32768 | t(14), 4) + "-" + n(t(48), 12);
			    }, e._gri = function(e) {
			        return e < 0 ? NaN : e <= 30 ? 0 | Math.random() * (1 << e) : e <= 53 ? (0 | Math.random() * (1 << 30)) + (0 | Math.random() * (1 << e - 30)) * (1 << 30) : NaN;
			    }, e._ha = function(e, t) {
			        var n = e.toString(16), r = t - n.length, i = "0";
			        for (; r > 0; r >>>= 1, i += i) r & 1 && (n = i + n);
			        return n;
			    }, e;
			}), define("dunF+D1VptGh1mvT/vo4D+cQh7io0eKZgvwrqCjcMow=", function() {
			    "use strict";
			    var e = function(e) {
			        this.x = e;
			    };
			    return e.prototype.next = function() {
			        var e = this.x, t = e;
			        return e <<= 13, t ^= e, e >>= 17, t ^= e, e <<= 5, t ^= e, this.x = t, (t + 2147483648) * (1 / 4294967296);
			    }, e.prototype.nextBetween = function(e, t) {
			        return e + this.next() * (t - e);
			    }, e;
			}), define("a6QMpZpC/oS8xcSHem/guTKp+NBdWdqqxoayLw/oN8Y=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=" ], function(e, t) {
			    "use strict";
			    var n = {};
			    return n.create = function() {
			        var t = e.createFloatArray(3);
			        return t[0] = 0, t[1] = 0, t[2] = 0, t;
			    }, n.clone = function(t) {
			        var n = e.createFloatArray(3);
			        return n[0] = t[0], n[1] = t[1], n[2] = t[2], n;
			    }, n.fromValues = function(t, n, r) {
			        var i = e.createFloatArray(3);
			        return i[0] = t, i[1] = n, i[2] = r, i;
			    }, n.copy = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e;
			    }, n.set = function(e, t, n, r) {
			        return e[0] = t, e[1] = n, e[2] = r, e;
			    }, n.add = function(e, t, n) {
			        return e[0] = t[0] + n[0], e[1] = t[1] + n[1], e[2] = t[2] + n[2], e;
			    }, n.subtract = function(e, t, n) {
			        return e[0] = t[0] - n[0], e[1] = t[1] - n[1], e[2] = t[2] - n[2], e;
			    }, n.sub = n.subtract, n.multiply = function(e, t, n) {
			        return e[0] = t[0] * n[0], e[1] = t[1] * n[1], e[2] = t[2] * n[2], e;
			    }, n.mul = n.multiply, n.divide = function(e, t, n) {
			        return e[0] = t[0] / n[0], e[1] = t[1] / n[1], e[2] = t[2] / n[2], e;
			    }, n.div = n.divide, n.min = function(e, t, n) {
			        return e[0] = Math.min(t[0], n[0]), e[1] = Math.min(t[1], n[1]), e[2] = Math.min(t[2], n[2]), e;
			    }, n.max = function(e, t, n) {
			        return e[0] = Math.max(t[0], n[0]), e[1] = Math.max(t[1], n[1]), e[2] = Math.max(t[2], n[2]), e;
			    }, n.scale = function(e, t, n) {
			        return e[0] = t[0] * n, e[1] = t[1] * n, e[2] = t[2] * n, e;
			    }, n.scaleAndAdd = function(e, t, n, r) {
			        return e[0] = t[0] + n[0] * r, e[1] = t[1] + n[1] * r, e[2] = t[2] + n[2] * r, e;
			    }, n.distance = function(e, t) {
			        var n = t[0] - e[0], r = t[1] - e[1], i = t[2] - e[2];
			        return Math.sqrt(n * n + r * r + i * i);
			    }, n.dist = n.distance, n.squaredDistance = function(e, t) {
			        var n = t[0] - e[0], r = t[1] - e[1], i = t[2] - e[2];
			        return n * n + r * r + i * i;
			    }, n.sqrDist = n.squaredDistance, n.length = function(e) {
			        var t = e[0], n = e[1], r = e[2];
			        return Math.sqrt(t * t + n * n + r * r);
			    }, n.len = n.length, n.squaredLength = function(e) {
			        var t = e[0], n = e[1], r = e[2];
			        return t * t + n * n + r * r;
			    }, n.sqrLen = n.squaredLength, n.negate = function(e, t) {
			        return e[0] = -t[0], e[1] = -t[1], e[2] = -t[2], e;
			    }, n.normalize = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = n * n + r * r + i * i;
			        return s > 0 && (s = 1 / Math.sqrt(s), e[0] = t[0] * s, e[1] = t[1] * s, e[2] = t[2] * s), e;
			    }, n.dot = function(e, t) {
			        return e[0] * t[0] + e[1] * t[1] + e[2] * t[2];
			    }, n.cross = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = n[0], u = n[1], a = n[2];
			        return e[0] = i * a - s * u, e[1] = s * o - r * a, e[2] = r * u - i * o, e;
			    }, n.lerp = function(e, t, n, r) {
			        var i = t[0], s = t[1], o = t[2];
			        return e[0] = i + r * (n[0] - i), e[1] = s + r * (n[1] - s), e[2] = o + r * (n[2] - o), e;
			    }, n.random = function(e, n) {
			        n = n || 1;
			        var r = t.random() * 2 * Math.PI, i = t.random() * 2 - 1, s = Math.sqrt(1 - i * i) * n;
			        return e[0] = Math.cos(r) * s, e[1] = Math.sin(r) * s, e[2] = i * n, e;
			    }, n.transformMat4 = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2];
			        return e[0] = n[0] * r + n[4] * i + n[8] * s + n[12], e[1] = n[1] * r + n[5] * i + n[9] * s + n[13], e[2] = n[2] * r + n[6] * i + n[10] * s + n[14], e;
			    }, n.transformMat3 = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2];
			        return e[0] = r * n[0] + i * n[3] + s * n[6], e[1] = r * n[1] + i * n[4] + s * n[7], e[2] = r * n[2] + i * n[5] + s * n[8], e;
			    }, n.transformQuat = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = n[0], u = n[1], a = n[2], f = n[3], l = f * r + u * s - a * i, c = f * i + a * r - o * s, h = f * s + o * i - u * r, p = -o * r - u * i - a * s;
			        return e[0] = l * f + p * -o + c * -a - h * -u, e[1] = c * f + p * -u + h * -o - l * -a, e[2] = h * f + p * -a + l * -u - c * -o, e;
			    }, n.forEach = function() {
			        var e = n.create();
			        return function(t, n, r, i, s, o) {
			            var u, a;
			            n || (n = 3), r || (r = 0), i ? a = Math.min(i * n + r, t.length) : a = t.length;
			            for (u = r; u < a; u += n) e[0] = t[u], e[1] = t[u + 1], e[2] = t[u + 2], s(e, e, o), t[u] = e[0], t[u + 1] = e[1], t[u + 2] = e[2];
			            return t;
			        };
			    }(), n.str = function(e) {
			        return "vec3(" + e[0] + ", " + e[1] + ", " + e[2] + ")";
			    }, n;
			}), define("HCQLCqor0eV+DAO4JM25Frq5bQkCpQpTDQEHtpXy9ag=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "a6QMpZpC/oS8xcSHem/guTKp+NBdWdqqxoayLw/oN8Y=", "UXTIupZGRczsgnUj2SpAlCuuFJw3p3TtznLNsAamIcQ=", "yVWG+StUPY2cpL5TJDIz/GlQdjOt3yQROd6W8z+bGks=" ], function(e, t, n, r) {
			    "use strict";
			    var i = {};
			    return i.create = function() {
			        var t = e.createFloatArray(4);
			        return t[0] = 0, t[1] = 0, t[2] = 0, t[3] = 1, t;
			    }, i.rotationTo = function() {
			        var e = t.create(), n = t.fromValues(1, 0, 0), r = t.fromValues(0, 1, 0);
			        return function(s, o, u) {
			            var a = t.dot(o, u);
			            return a < -.999999 ? (t.cross(e, n, o), t.length(e) < 1e-6 && t.cross(e, r, o), t.normalize(e, e), i.setAxisAngle(s, e, Math.PI), s) : a > .999999 ? (s[0] = 0, s[1] = 0, s[2] = 0, s[3] = 1, s) : (t.cross(e, o, u), s[0] = e[0], s[1] = e[1], s[2] = e[2], s[3] = 1 + a, i.normalize(s, s));
			        };
			    }(), i.setAxes = function() {
			        var e = r.create();
			        return function(t, n, r, s) {
			            return e[0] = r[0], e[3] = r[1], e[6] = r[2], e[1] = s[0], e[4] = s[1], e[7] = s[2], e[2] = n[0], e[5] = n[1], e[8] = n[2], i.normalize(t, i.fromMat3(t, e));
			        };
			    }(), i.clone = n.clone, i.fromValues = n.fromValues, i.copy = n.copy, i.set = n.set, i.identity = function(e) {
			        return e[0] = 0, e[1] = 0, e[2] = 0, e[3] = 1, e;
			    }, i.setAxisAngle = function(e, t, n) {
			        n *= .5;
			        var r = Math.sin(n);
			        return e[0] = r * t[0], e[1] = r * t[1], e[2] = r * t[2], e[3] = Math.cos(n), e;
			    }, i.add = n.add, i.multiply = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = n[0], a = n[1], f = n[2], l = n[3];
			        return e[0] = r * l + o * u + i * f - s * a, e[1] = i * l + o * a + s * u - r * f, e[2] = s * l + o * f + r * a - i * u, e[3] = o * l - r * u - i * a - s * f, e;
			    }, i.mul = i.multiply, i.scale = n.scale, i.rotateX = function(e, t, n) {
			        n *= .5;
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = Math.sin(n), a = Math.cos(n);
			        return e[0] = r * a + o * u, e[1] = i * a + s * u, e[2] = s * a - i * u, e[3] = o * a - r * u, e;
			    }, i.rotateY = function(e, t, n) {
			        n *= .5;
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = Math.sin(n), a = Math.cos(n);
			        return e[0] = r * a - s * u, e[1] = i * a + o * u, e[2] = s * a + r * u, e[3] = o * a - i * u, e;
			    }, i.rotateZ = function(e, t, n) {
			        n *= .5;
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = Math.sin(n), a = Math.cos(n);
			        return e[0] = r * a + i * u, e[1] = i * a - r * u, e[2] = s * a + o * u, e[3] = o * a - s * u, e;
			    }, i.calculateW = function(e, t) {
			        var n = t[0], r = t[1], i = t[2];
			        return e[0] = n, e[1] = r, e[2] = i, e[3] = -Math.sqrt(Math.abs(1 - n * n - r * r - i * i)), e;
			    }, i.dot = n.dot, i.lerp = n.lerp, i.slerp = function(e, t, n, r) {
			        var i = t[0], s = t[1], o = t[2], u = t[3], a = n[0], f = n[1], l = n[2], c = n[3], h, p, d, v, m;
			        return p = i * a + s * f + o * l + u * c, p < 0 && (p = -p, a = -a, f = -f, l = -l, c = -c), 1 - p > 1e-6 ? (h = Math.acos(p), d = Math.sin(h), v = Math.sin((1 - r) * h) / d, m = Math.sin(r * h) / d) : (v = 1 - r, m = r), e[0] = v * i + m * a, e[1] = v * s + m * f, e[2] = v * o + m * l, e[3] = v * u + m * c, e;
			    }, i.invert = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = n * n + r * r + i * i + s * s, u = o ? 1 / o : 0;
			        return e[0] = -n * u, e[1] = -r * u, e[2] = -i * u, e[3] = s * u, e;
			    }, i.conjugate = function(e, t) {
			        return e[0] = -t[0], e[1] = -t[1], e[2] = -t[2], e[3] = t[3], e;
			    }, i.length = n.length, i.len = i.length, i.squaredLength = n.squaredLength, i.sqrLen = i.squaredLength, i.normalize = n.normalize, i.fromMat3 = function() {
			        var t = e.Int8Array.fromValues([ 1, 2, 0 ]);
			        return function(e, n) {
			            var r = n[0] + n[4] + n[8], i;
			            if (r > 0) i = Math.sqrt(r + 1), e[3] = .5 * i, i = .5 / i, e[0] = (n[7] - n[5]) * i, e[1] = (n[2] - n[6]) * i, e[2] = (n[3] - n[1]) * i; else {
			                var s = 0;
			                n[4] > n[0] && (s = 1), n[8] > n[s * 3 + s] && (s = 2);
			                var o = t[s], u = t[o];
			                i = Math.sqrt(n[s * 3 + s] - n[o * 3 + o] - n[u * 3 + u] + 1), e[s] = .5 * i, i = .5 / i, e[3] = (n[u * 3 + o] - n[o * 3 + u]) * i, e[o] = (n[o * 3 + s] + n[s * 3 + o]) * i, e[u] = (n[u * 3 + s] + n[s * 3 + u]) * i;
			            }
			            return e;
			        };
			    }(), i.str = function(e) {
			        return "quat(" + e[0] + ", " + e[1] + ", " + e[2] + ", " + e[3] + ")";
			    }, i;
			}), define("9h1VbSkUkR0rOE8ony/LEvlqT9hawoj6Npu6TdQx4pI=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=" ], function(e, t) {
			    "use strict";
			    var n = {};
			    return n.create = function() {
			        var t = e.createFloatArray(16);
			        return t[0] = 1, t[1] = 0, t[2] = 0, t[3] = 0, t[4] = 0, t[5] = 1, t[6] = 0, t[7] = 0, t[8] = 0, t[9] = 0, t[10] = 1, t[11] = 0, t[12] = 0, t[13] = 0, t[14] = 0, t[15] = 1, t;
			    }, n.clone = function(t) {
			        var n = e.createFloatArray(16);
			        return n[0] = t[0], n[1] = t[1], n[2] = t[2], n[3] = t[3], n[4] = t[4], n[5] = t[5], n[6] = t[6], n[7] = t[7], n[8] = t[8], n[9] = t[9], n[10] = t[10], n[11] = t[11], n[12] = t[12], n[13] = t[13], n[14] = t[14], n[15] = t[15], n;
			    }, n.copy = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[3], e[4] = t[4], e[5] = t[5], e[6] = t[6], e[7] = t[7], e[8] = t[8], e[9] = t[9], e[10] = t[10], e[11] = t[11], e[12] = t[12], e[13] = t[13], e[14] = t[14], e[15] = t[15], e;
			    }, n.identity = function(e) {
			        return e[0] = 1, e[1] = 0, e[2] = 0, e[3] = 0, e[4] = 0, e[5] = 1, e[6] = 0, e[7] = 0, e[8] = 0, e[9] = 0, e[10] = 1, e[11] = 0, e[12] = 0, e[13] = 0, e[14] = 0, e[15] = 1, e;
			    }, n.transpose = function(e, t) {
			        if (e === t) {
			            var n = t[1], r = t[2], i = t[3], s = t[6], o = t[7], u = t[11];
			            e[1] = t[4], e[2] = t[8], e[3] = t[12], e[4] = n, e[6] = t[9], e[7] = t[13], e[8] = r, e[9] = s, e[11] = t[14], e[12] = i, e[13] = o, e[14] = u;
			        } else e[0] = t[0], e[1] = t[4], e[2] = t[8], e[3] = t[12], e[4] = t[1], e[5] = t[5], e[6] = t[9], e[7] = t[13], e[8] = t[2], e[9] = t[6], e[10] = t[10], e[11] = t[14], e[12] = t[3], e[13] = t[7], e[14] = t[11], e[15] = t[15];
			        return e;
			    }, n.invert = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = t[4], u = t[5], a = t[6], f = t[7], l = t[8], c = t[9], h = t[10], p = t[11], d = t[12], v = t[13], m = t[14], g = t[15], y = n * u - r * o, b = n * a - i * o, w = n * f - s * o, E = r * a - i * u, S = r * f - s * u, x = i * f - s * a, T = l * v - c * d, N = l * m - h * d, C = l * g - p * d, k = c * m - h * v, L = c * g - p * v, A = h * g - p * m, O = y * A - b * L + w * k + E * C - S * N + x * T;
			        return O ? (O = 1 / O, e[0] = (u * A - a * L + f * k) * O, e[1] = (i * L - r * A - s * k) * O, e[2] = (v * x - m * S + g * E) * O, e[3] = (h * S - c * x - p * E) * O, e[4] = (a * C - o * A - f * N) * O, e[5] = (n * A - i * C + s * N) * O, e[6] = (m * w - d * x - g * b) * O, e[7] = (l * x - h * w + p * b) * O, e[8] = (o * L - u * C + f * T) * O, e[9] = (r * C - n * L - s * T) * O, e[10] = (d * S - v * w + g * y) * O, e[11] = (c * w - l * S - p * y) * O, e[12] = (u * N - o * k - a * T) * O, e[13] = (n * k - r * N + i * T) * O, e[14] = (v * b - d * E - m * y) * O, e[15] = (l * E - c * b + h * y) * O, e) : null;
			    }, n.adjoint = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = t[4], u = t[5], a = t[6], f = t[7], l = t[8], c = t[9], h = t[10], p = t[11], d = t[12], v = t[13], m = t[14], g = t[15];
			        return e[0] = u * (h * g - p * m) - c * (a * g - f * m) + v * (a * p - f * h), e[1] = -(r * (h * g - p * m) - c * (i * g - s * m) + v * (i * p - s * h)), e[2] = r * (a * g - f * m) - u * (i * g - s * m) + v * (i * f - s * a), e[3] = -(r * (a * p - f * h) - u * (i * p - s * h) + c * (i * f - s * a)), e[4] = -(o * (h * g - p * m) - l * (a * g - f * m) + d * (a * p - f * h)), e[5] = n * (h * g - p * m) - l * (i * g - s * m) + d * (i * p - s * h), e[6] = -(n * (a * g - f * m) - o * (i * g - s * m) + d * (i * f - s * a)), e[7] = n * (a * p - f * h) - o * (i * p - s * h) + l * (i * f - s * a), e[8] = o * (c * g - p * v) - l * (u * g - f * v) + d * (u * p - f * c), e[9] = -(n * (c * g - p * v) - l * (r * g - s * v) + d * (r * p - s * c)), e[10] = n * (u * g - f * v) - o * (r * g - s * v) + d * (r * f - s * u), e[11] = -(n * (u * p - f * c) - o * (r * p - s * c) + l * (r * f - s * u)), e[12] = -(o * (c * m - h * v) - l * (u * m - a * v) + d * (u * h - a * c)), e[13] = n * (c * m - h * v) - l * (r * m - i * v) + d * (r * h - i * c), e[14] = -(n * (u * m - a * v) - o * (r * m - i * v) + d * (r * a - i * u)), e[15] = n * (u * h - a * c) - o * (r * h - i * c) + l * (r * a - i * u), e;
			    }, n.determinant = function(e) {
			        var t = e[0], n = e[1], r = e[2], i = e[3], s = e[4], o = e[5], u = e[6], a = e[7], f = e[8], l = e[9], c = e[10], h = e[11], p = e[12], d = e[13], v = e[14], m = e[15], g = t * o - n * s, y = t * u - r * s, b = t * a - i * s, w = n * u - r * o, E = n * a - i * o, S = r * a - i * u, x = f * d - l * p, T = f * v - c * p, N = f * m - h * p, C = l * v - c * d, k = l * m - h * d, L = c * m - h * v;
			        return g * L - y * k + b * C + w * N - E * T + S * x;
			    }, n.multiply = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = t[4], a = t[5], f = t[6], l = t[7], c = t[8], h = t[9], p = t[10], d = t[11], v = t[12], m = t[13], g = t[14], y = t[15], b = n[0], w = n[1], E = n[2], S = n[3];
			        return e[0] = b * r + w * u + E * c + S * v, e[1] = b * i + w * a + E * h + S * m, e[2] = b * s + w * f + E * p + S * g, e[3] = b * o + w * l + E * d + S * y, b = n[4], w = n[5], E = n[6], S = n[7], e[4] = b * r + w * u + E * c + S * v, e[5] = b * i + w * a + E * h + S * m, e[6] = b * s + w * f + E * p + S * g, e[7] = b * o + w * l + E * d + S * y, b = n[8], w = n[9], E = n[10], S = n[11], e[8] = b * r + w * u + E * c + S * v, e[9] = b * i + w * a + E * h + S * m, e[10] = b * s + w * f + E * p + S * g, e[11] = b * o + w * l + E * d + S * y, b = n[12], w = n[13], E = n[14], S = n[15], e[12] = b * r + w * u + E * c + S * v, e[13] = b * i + w * a + E * h + S * m, e[14] = b * s + w * f + E * p + S * g, e[15] = b * o + w * l + E * d + S * y, e;
			    }, n.mul = n.multiply, n.translate = function(e, t, n) {
			        var r = n[0], i = n[1], s = n[2], o, u, a, f, l, c, h, p, d, v, m, g;
			        return t === e ? (e[12] = t[0] * r + t[4] * i + t[8] * s + t[12], e[13] = t[1] * r + t[5] * i + t[9] * s + t[13], e[14] = t[2] * r + t[6] * i + t[10] * s + t[14], e[15] = t[3] * r + t[7] * i + t[11] * s + t[15]) : (o = t[0], u = t[1], a = t[2], f = t[3], l = t[4], c = t[5], h = t[6], p = t[7], d = t[8], v = t[9], m = t[10], g = t[11], e[0] = o, e[1] = u, e[2] = a, e[3] = f, e[4] = l, e[5] = c, e[6] = h, e[7] = p, e[8] = d, e[9] = v, e[10] = m, e[11] = g, e[12] = o * r + l * i + d * s + t[12], e[13] = u * r + c * i + v * s + t[13], e[14] = a * r + h * i + m * s + t[14], e[15] = f * r + p * i + g * s + t[15]), e;
			    }, n.scale = function(e, t, n) {
			        var r = n[0], i = n[1], s = n[2];
			        return e[0] = t[0] * r, e[1] = t[1] * r, e[2] = t[2] * r, e[3] = t[3] * r, e[4] = t[4] * i, e[5] = t[5] * i, e[6] = t[6] * i, e[7] = t[7] * i, e[8] = t[8] * s, e[9] = t[9] * s, e[10] = t[10] * s, e[11] = t[11] * s, e[12] = t[12], e[13] = t[13], e[14] = t[14], e[15] = t[15], e;
			    }, n.rotate = function(e, n, r, i) {
			        var s = i[0], o = i[1], u = i[2], a = Math.sqrt(s * s + o * o + u * u), f, l, c, h, p, d, v, m, g, y, b, w, E, S, x, T, N, C, k, L, A, O, M, _;
			        return Math.abs(a) < t.FLOAT_EPSILON ? null : (a = 1 / a, s *= a, o *= a, u *= a, f = Math.sin(r), l = Math.cos(r), c = 1 - l, h = n[0], p = n[1], d = n[2], v = n[3], m = n[4], g = n[5], y = n[6], b = n[7], w = n[8], E = n[9], S = n[10], x = n[11], T = s * s * c + l, N = o * s * c + u * f, C = u * s * c - o * f, k = s * o * c - u * f, L = o * o * c + l, A = u * o * c + s * f, O = s * u * c + o * f, M = o * u * c - s * f, _ = u * u * c + l, e[0] = h * T + m * N + w * C, e[1] = p * T + g * N + E * C, e[2] = d * T + y * N + S * C, e[3] = v * T + b * N + x * C, e[4] = h * k + m * L + w * A, e[5] = p * k + g * L + E * A, e[6] = d * k + y * L + S * A, e[7] = v * k + b * L + x * A, e[8] = h * O + m * M + w * _, e[9] = p * O + g * M + E * _, e[10] = d * O + y * M + S * _, e[11] = v * O + b * M + x * _, n !== e && (e[12] = n[12], e[13] = n[13], e[14] = n[14], e[15] = n[15]), e);
			    }, n.rotateX = function(e, t, n) {
			        var r = Math.sin(n), i = Math.cos(n), s = t[4], o = t[5], u = t[6], a = t[7], f = t[8], l = t[9], c = t[10], h = t[11];
			        return t !== e && (e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[3], e[12] = t[12], e[13] = t[13], e[14] = t[14], e[15] = t[15]), e[4] = s * i + f * r, e[5] = o * i + l * r, e[6] = u * i + c * r, e[7] = a * i + h * r, e[8] = f * i - s * r, e[9] = l * i - o * r, e[10] = c * i - u * r, e[11] = h * i - a * r, e;
			    }, n.rotateY = function(e, t, n) {
			        var r = Math.sin(n), i = Math.cos(n), s = t[0], o = t[1], u = t[2], a = t[3], f = t[8], l = t[9], c = t[10], h = t[11];
			        return t !== e && (e[4] = t[4], e[5] = t[5], e[6] = t[6], e[7] = t[7], e[12] = t[12], e[13] = t[13], e[14] = t[14], e[15] = t[15]), e[0] = s * i - f * r, e[1] = o * i - l * r, e[2] = u * i - c * r, e[3] = a * i - h * r, e[8] = s * r + f * i, e[9] = o * r + l * i, e[10] = u * r + c * i, e[11] = a * r + h * i, e;
			    }, n.rotateZ = function(e, t, n) {
			        var r = Math.sin(n), i = Math.cos(n), s = t[0], o = t[1], u = t[2], a = t[3], f = t[4], l = t[5], c = t[6], h = t[7];
			        return t !== e && (e[8] = t[8], e[9] = t[9], e[10] = t[10], e[11] = t[11], e[12] = t[12], e[13] = t[13], e[14] = t[14], e[15] = t[15]), e[0] = s * i + f * r, e[1] = o * i + l * r, e[2] = u * i + c * r, e[3] = a * i + h * r, e[4] = f * i - s * r, e[5] = l * i - o * r, e[6] = c * i - u * r, e[7] = h * i - a * r, e;
			    }, n.fromRotationTranslation = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = r + r, a = i + i, f = s + s, l = r * u, c = r * a, h = r * f, p = i * a, d = i * f, v = s * f, m = o * u, g = o * a, y = o * f;
			        return e[0] = 1 - (p + v), e[1] = c + y, e[2] = h - g, e[3] = 0, e[4] = c - y, e[5] = 1 - (l + v), e[6] = d + m, e[7] = 0, e[8] = h + g, e[9] = d - m, e[10] = 1 - (l + p), e[11] = 0, e[12] = n[0], e[13] = n[1], e[14] = n[2], e[15] = 1, e;
			    }, n.fromQuat = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = n + n, u = r + r, a = i + i, f = n * o, l = n * u, c = n * a, h = r * u, p = r * a, d = i * a, v = s * o, m = s * u, g = s * a;
			        return e[0] = 1 - (h + d), e[1] = l + g, e[2] = c - m, e[3] = 0, e[4] = l - g, e[5] = 1 - (f + d), e[6] = p + v, e[7] = 0, e[8] = c + m, e[9] = p - v, e[10] = 1 - (f + h), e[11] = 0, e[12] = 0, e[13] = 0, e[14] = 0, e[15] = 1, e;
			    }, n.frustum = function(e, t, n, r, i, s, o) {
			        var u = 1 / (n - t), a = 1 / (i - r), f = 1 / (s - o);
			        return e[0] = s * 2 * u, e[1] = 0, e[2] = 0, e[3] = 0, e[4] = 0, e[5] = s * 2 * a, e[6] = 0, e[7] = 0, e[8] = (n + t) * u, e[9] = (i + r) * a, e[10] = (o + s) * f, e[11] = -1, e[12] = 0, e[13] = 0, e[14] = o * s * 2 * f, e[15] = 0, e;
			    }, n.perspective = function(e, t, n, r, i) {
			        var s = 1 / Math.tan(t / 2), o = 1 / (r - i);
			        return e[0] = s / n, e[1] = 0, e[2] = 0, e[3] = 0, e[4] = 0, e[5] = s, e[6] = 0, e[7] = 0, e[8] = 0, e[9] = 0, e[10] = (i + r) * o, e[11] = -1, e[12] = 0, e[13] = 0, e[14] = 2 * i * r * o, e[15] = 0, e;
			    }, n.ortho = function(e, t, n, r, i, s, o) {
			        var u = 1 / (t - n), a = 1 / (r - i), f = 1 / (s - o);
			        return e[0] = -2 * u, e[1] = 0, e[2] = 0, e[3] = 0, e[4] = 0, e[5] = -2 * a, e[6] = 0, e[7] = 0, e[8] = 0, e[9] = 0, e[10] = 2 * f, e[11] = 0, e[12] = (t + n) * u, e[13] = (i + r) * a, e[14] = (o + s) * f, e[15] = 1, e;
			    }, n.lookAt = function(e, r, i, s) {
			        var o, u, a, f, l, c, h, p, d, v, m = r[0], g = r[1], y = r[2], b = s[0], w = s[1], E = s[2], S = i[0], x = i[1], T = i[2];
			        return Math.abs(m - S) < t.FLOAT_EPSILON && Math.abs(g - x) < t.FLOAT_EPSILON && Math.abs(y - T) < t.FLOAT_EPSILON ? n.identity(e) : (h = m - S, p = g - x, d = y - T, v = 1 / Math.sqrt(h * h + p * p + d * d), h *= v, p *= v, d *= v, o = w * d - E * p, u = E * h - b * d, a = b * p - w * h, v = Math.sqrt(o * o + u * u + a * a), v ? (v = 1 / v, o *= v, u *= v, a *= v) : (o = 0, u = 0, a = 0), f = p * a - d * u, l = d * o - h * a, c = h * u - p * o, v = Math.sqrt(f * f + l * l + c * c), v ? (v = 1 / v, f *= v, l *= v, c *= v) : (f = 0, l = 0, c = 0), e[0] = o, e[1] = f, e[2] = h, e[3] = 0, e[4] = u, e[5] = l, e[6] = p, e[7] = 0, e[8] = a, e[9] = c, e[10] = d, e[11] = 0, e[12] = -(o * m + u * g + a * y), e[13] = -(f * m + l * g + c * y), e[14] = -(h * m + p * g + d * y), e[15] = 1, e);
			    }, n.str = function(e) {
			        return "mat4(" + e[0] + ", " + e[1] + ", " + e[2] + ", " + e[3] + ", " + e[4] + ", " + e[5] + ", " + e[6] + ", " + e[7] + ", " + e[8] + ", " + e[9] + ", " + e[10] + ", " + e[11] + ", " + e[12] + ", " + e[13] + ", " + e[14] + ", " + e[15] + ")";
			    }, n;
			}), define("wmv6Nu5PrhR2GBQseWUtsQS+j5FlMm6CQ794XX3Cd9A=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=" ], function(e) {
			    "use strict";
			    var t = {};
			    return t.create = function() {
			        var t = e.createFloatArray(6);
			        return t[0] = 1, t[1] = 0, t[2] = 0, t[3] = 1, t[4] = 0, t[5] = 0, t;
			    }, t.clone = function(t) {
			        var n = e.createFloatArray(6);
			        return n[0] = t[0], n[1] = t[1], n[2] = t[2], n[3] = t[3], n[4] = t[4], n[5] = t[5], n;
			    }, t.copy = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[3], e[4] = t[4], e[5] = t[5], e;
			    }, t.identity = function(e) {
			        return e[0] = 1, e[1] = 0, e[2] = 0, e[3] = 1, e[4] = 0, e[5] = 0, e;
			    }, t.invert = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = t[4], u = t[5], a = n * s - r * i;
			        return a ? (a = 1 / a, e[0] = s * a, e[1] = -r * a, e[2] = -i * a, e[3] = n * a, e[4] = (i * u - s * o) * a, e[5] = (r * o - n * u) * a, e) : null;
			    }, t.determinant = function(e) {
			        return e[0] * e[3] - e[1] * e[2];
			    }, t.multiply = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = t[4], a = t[5], f = n[0], l = n[1], c = n[2], h = n[3], p = n[4], d = n[5];
			        return e[0] = r * f + i * c, e[1] = r * l + i * h, e[2] = s * f + o * c, e[3] = s * l + o * h, e[4] = f * u + c * a + p, e[5] = l * u + h * a + d, e;
			    }, t.mul = t.multiply, t.rotate = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = t[4], a = t[5], f = Math.sin(n), l = Math.cos(n);
			        return e[0] = r * l + i * f, e[1] = -r * f + i * l, e[2] = s * l + o * f, e[3] = -s * f + l * o, e[4] = l * u + f * a, e[5] = l * a - f * u, e;
			    }, t.scale = function(e, t, n) {
			        var r = n[0], i = n[1];
			        return e[0] = t[0] * r, e[1] = t[1] * i, e[2] = t[2] * r, e[3] = t[3] * i, e[4] = t[4] * r, e[5] = t[5] * i, e;
			    }, t.translate = function(e, t, n) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[3], e[4] = t[4] + n[0], e[5] = t[5] + n[1], e;
			    }, t.str = function(e) {
			        return "mat2d(" + e[0] + ", " + e[1] + ", " + e[2] + ", " + e[3] + ", " + e[4] + ", " + e[5] + ")";
			    }, t;
			}), define("UPOGxICBwHHAJnhEO0kYe4CbSZksrC7moXiy6Wgb0MM=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=" ], function(e) {
			    "use strict";
			    var t = {};
			    return t.create = function() {
			        var t = e.createFloatArray(4);
			        return t[0] = 1, t[1] = 0, t[2] = 0, t[3] = 1, t;
			    }, t.clone = function(t) {
			        var n = e.createFloatArray(4);
			        return n[0] = t[0], n[1] = t[1], n[2] = t[2], n[3] = t[3], n;
			    }, t.copy = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[3], e;
			    }, t.identity = function(e) {
			        return e[0] = 1, e[1] = 0, e[2] = 0, e[3] = 1, e;
			    }, t.transpose = function(e, t) {
			        if (e === t) {
			            var n = t[1];
			            e[1] = t[2], e[2] = n;
			        } else e[0] = t[0], e[1] = t[2], e[2] = t[1], e[3] = t[3];
			        return e;
			    }, t.invert = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = n * s - i * r;
			        return o ? (o = 1 / o, e[0] = s * o, e[1] = -r * o, e[2] = -i * o, e[3] = n * o, e) : null;
			    }, t.adjoint = function(e, t) {
			        var n = t[0];
			        return e[0] = t[3], e[1] = -t[1], e[2] = -t[2], e[3] = n, e;
			    }, t.determinant = function(e) {
			        return e[0] * e[3] - e[2] * e[1];
			    }, t.multiply = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = n[0], a = n[1], f = n[2], l = n[3];
			        return e[0] = r * u + i * f, e[1] = r * a + i * l, e[2] = s * u + o * f, e[3] = s * a + o * l, e;
			    }, t.mul = t.multiply, t.rotate = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = Math.sin(n), a = Math.cos(n);
			        return e[0] = r * a + i * u, e[1] = r * -u + i * a, e[2] = s * a + o * u, e[3] = s * -u + o * a, e;
			    }, t.scale = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = n[0], a = n[1];
			        return e[0] = r * u, e[1] = i * a, e[2] = s * u, e[3] = o * a, e;
			    }, t.str = function(e) {
			        return "mat2(" + e[0] + ", " + e[1] + ", " + e[2] + ", " + e[3] + ")";
			    }, t;
			}), define("DL2XO5bR2mezFB5wDHhPp+WUMECQNrIMAg+5DYokByc=", function() {
			    "use strict";
			    var e = function(e, t) {
			        return e[0] <= t[0] && e[1] > t[1] && e[2] <= t[2] && e[3] > t[3];
			    }, t = function(e, t) {
			        return e[0] <= t[1] && t[0] < e[1] && e[2] <= t[3] && t[2] < e[3];
			    }, n = function(e) {
			        var t = e.bound, n = t[0], r = t[1], i = t[2], s = t[3], o = (n + r) * .5, u = (i + s) * .5, a = e.children;
			        a[0] = l(e, [ o, r, u, s ]), a[1] = l(e, [ n, o, u, s ]), a[2] = l(e, [ n, o, i, u ]), a[3] = l(e, [ o, r, i, u ]);
			    }, r = function(e) {
			        var t = e.children;
			        t[0].parent = undefined, t[0] = undefined, t[1].parent = undefined, t[1] = undefined, t[2].parent = undefined, t[2] = undefined, t[3].parent = undefined, t[3] = undefined;
			    }, i = function(e, t, n) {
			        var r = s(t, n, n.bound), i = n.id;
			        if (!r) throw "Could not insert item " + i ? ' with id "' + i + '" ' : "because it is not contained in the space covered by the tree.";
			        i && (e[i] = r);
			    }, s = function(t, r, i) {
			        if (!e(t.bound, i)) return;
			        var o = t.children;
			        o[0] || n(t);
			        for (var u = 0, a; u < 4; u++) {
			            a = s(o[u], r, i);
			            if (a) return t.numDescendantItems++, a;
			        }
			        if (!a) return t.items[r.id] = r, t;
			    }, o = function(e, t) {
			        delete e.items[t];
			        var n = e.parent;
			        while (n) n.numDescendantItems--, n.numDescendantItems === 0 && r(n), n = n.parent;
			    }, u = function(n, r, i) {
			        var s = n.items;
			        for (var o in s) {
			            var f = s[o], l = f.bound;
			            if (e(l, r) || e(r, l) || t(r, l)) i[o] = f.payload;
			        }
			        var c = n.children;
			        if (!c[0]) return;
			        for (var h = 0; h < 4; h++) {
			            var p = c[h], d = p.bound;
			            if (e(r, d)) a(p, i); else {
			                if (e(d, r)) {
			                    u(p, r, i);
			                    break;
			                }
			                t(d, r) && u(p, r, i);
			            }
			        }
			    }, a = function(e, t) {
			        var n = e.items;
			        for (var r in n) t[r] = n[r].payload;
			        var i = e.children;
			        if (!i[0]) return;
			        for (var s = 0; s < 4; s++) a(i[s], t);
			    }, f = function(e, t) {
			        var n = t[0] * .5, r = t[1] * .5;
			        return [ e[0] - n, e[0] + n, e[1] - r, e[1] + r ];
			    }, l = function(e, t) {
			        return {
			            parent: e,
			            children: new Array(4),
			            bound: t,
			            items: {},
			            numDescendantItems: 0
			        };
			    }, c = function(e, t, n, r, i) {
			        return n || (t = [ 0, 0 ], n = [ e - 1, e - 1 ]), {
			            id: i,
			            bound: f(t, n),
			            payload: r
			        };
			    }, h = function(e) {
			        this.idToNode = {}, this.size = e, this.root = l(null, f([ 0, 0 ], [ e, e ]));
			    };
			    return h.prototype = {
			        insert: function(e, t, n, r) {
			            if (r && this.idToNode[r]) throw 'The provided id "' + r + '" is already in use.';
			            i(this.idToNode, this.root, c(this.size, e, t, n, r));
			        },
			        remove: function(e) {
			            var t = this.idToNode[e];
			            if (!t) return;
			            o(t, e), delete this.idToNode[e];
			        },
			        search: function(e, t) {
			            var n = {};
			            return u(this.root, f(e, t), n), n;
			        }
			    }, h;
			}), define("z7TX6BsmUcv0nH/bqr0j7VkT7tQUPxwYZT67+lzEXGk=", function() {
			    "use strict";
			    return function(e, t, n) {
			        var r = e[0], i = e[1], s = r / i;
			        return t <= s ? r = t * i : i = r / t, n && (r = Math.round(r), i = Math.round(i)), [ r, i ];
			    };
			}), define("4vsnWAiE5zSFrXpOOZ2hdE2ZexQK0X61B2rw4N6SvLs=", [ "z7TX6BsmUcv0nH/bqr0j7VkT7tQUPxwYZT67+lzEXGk=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", "yVWG+StUPY2cpL5TJDIz/GlQdjOt3yQROd6W8z+bGks=", "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=" ], function(e, t, n, r) {
			    "use strict";
			    var i = n.identity(n.create()), s = r.create(), o = function(e, t, n, r, i, s) {
			        if (!s || s < 0) s = 1;
			        var o = s * 2;
			        e.save(), e.fillRect(t, n, r, s), e.fillRect(t, n + i - s, r, s), e.fillRect(t, n + s, s, i - o), e.fillRect(t + r - s, n + s, s, i - o), e.restore();
			    };
			    return function(u, a, f, l) {
			        var c = l.scale, h = [ 1, 0, 1, 1 ], p = r.multiply(s, f, c), d = p[0] / p[1], v = e(a, d), m = r.scale(s, r.subtract(s, a, v), .5);
			        u.save(), t.mat3Ortho(i, 0, a[0], 0, a[1]), n.translate(i, i, m), u.setViewMatrix(i), u.setColor(h), o(u, 0, 0, v[0], v[1], 2), u.restore();
			    };
			}), define("yVWG+StUPY2cpL5TJDIz/GlQdjOt3yQROd6W8z+bGks=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=" ], function(e) {
			    "use strict";
			    var t = {};
			    return t.create = function() {
			        var t = e.createFloatArray(9);
			        return t[0] = 1, t[1] = 0, t[2] = 0, t[3] = 0, t[4] = 1, t[5] = 0, t[6] = 0, t[7] = 0, t[8] = 1, t;
			    }, t.fromMat4 = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[4], e[4] = t[5], e[5] = t[6], e[6] = t[8], e[7] = t[9], e[8] = t[10], e;
			    }, t.clone = function(t) {
			        var n = e.createFloatArray(9);
			        return n[0] = t[0], n[1] = t[1], n[2] = t[2], n[3] = t[3], n[4] = t[4], n[5] = t[5], n[6] = t[6], n[7] = t[7], n[8] = t[8], n;
			    }, t.copy = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[3], e[4] = t[4], e[5] = t[5], e[6] = t[6], e[7] = t[7], e[8] = t[8], e;
			    }, t.identity = function(e) {
			        return e[0] = 1, e[1] = 0, e[2] = 0, e[3] = 0, e[4] = 1, e[5] = 0, e[6] = 0, e[7] = 0, e[8] = 1, e;
			    }, t.transpose = function(e, t) {
			        if (e === t) {
			            var n = t[1], r = t[2], i = t[5];
			            e[1] = t[3], e[2] = t[6], e[3] = n, e[5] = t[7], e[6] = r, e[7] = i;
			        } else e[0] = t[0], e[1] = t[3], e[2] = t[6], e[3] = t[1], e[4] = t[4], e[5] = t[7], e[6] = t[2], e[7] = t[5], e[8] = t[8];
			        return e;
			    }, t.invert = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = t[4], u = t[5], a = t[6], f = t[7], l = t[8], c = l * o - u * f, h = -l * s + u * a, p = f * s - o * a, d = n * c + r * h + i * p;
			        return d ? (d = 1 / d, e[0] = c * d, e[1] = (-l * r + i * f) * d, e[2] = (u * r - i * o) * d, e[3] = h * d, e[4] = (l * n - i * a) * d, e[5] = (-u * n + i * s) * d, e[6] = p * d, e[7] = (-f * n + r * a) * d, e[8] = (o * n - r * s) * d, e) : null;
			    }, t.adjoint = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = t[4], u = t[5], a = t[6], f = t[7], l = t[8];
			        return e[0] = o * l - u * f, e[1] = i * f - r * l, e[2] = r * u - i * o, e[3] = u * a - s * l, e[4] = n * l - i * a, e[5] = i * s - n * u, e[6] = s * f - o * a, e[7] = r * a - n * f, e[8] = n * o - r * s, e;
			    }, t.determinant = function(e) {
			        var t = e[0], n = e[1], r = e[2], i = e[3], s = e[4], o = e[5], u = e[6], a = e[7], f = e[8];
			        return t * (f * s - o * a) + n * (-f * i + o * u) + r * (a * i - s * u);
			    }, t.multiply = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = t[4], a = t[5], f = t[6], l = t[7], c = t[8], h = n[0], p = n[1], d = n[2], v = n[3], m = n[4], g = n[5], y = n[6], b = n[7], w = n[8];
			        return e[0] = h * r + p * o + d * f, e[1] = h * i + p * u + d * l, e[2] = h * s + p * a + d * c, e[3] = v * r + m * o + g * f, e[4] = v * i + m * u + g * l, e[5] = v * s + m * a + g * c, e[6] = y * r + b * o + w * f, e[7] = y * i + b * u + w * l, e[8] = y * s + b * a + w * c, e;
			    }, t.mul = t.multiply, t.translate = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = t[4], a = t[5], f = t[6], l = t[7], c = t[8], h = n[0], p = n[1];
			        return e[0] = r, e[1] = i, e[2] = s, e[3] = o, e[4] = u, e[5] = a, e[6] = h * r + p * o + f, e[7] = h * i + p * u + l, e[8] = h * s + p * a + c, e;
			    }, t.rotate = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3], u = t[4], a = t[5], f = t[6], l = t[7], c = t[8], h = Math.sin(n), p = Math.cos(n);
			        return e[0] = p * r + h * o, e[1] = p * i + h * u, e[2] = p * s + h * a, e[3] = p * o - h * r, e[4] = p * u - h * i, e[5] = p * a - h * s, e[6] = f, e[7] = l, e[8] = c, e;
			    }, t.scale = function(e, t, n) {
			        var r = n[0], i = n[1];
			        return e[0] = r * t[0], e[1] = r * t[1], e[2] = r * t[2], e[3] = i * t[3], e[4] = i * t[4], e[5] = i * t[5], e[6] = t[6], e[7] = t[7], e[8] = t[8], e;
			    }, t.fromMat2d = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = 0, e[3] = t[2], e[4] = t[3], e[5] = 0, e[6] = t[4], e[7] = t[5], e[8] = 1, e;
			    }, t.fromQuat = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = n + n, u = r + r, a = i + i, f = n * o, l = n * u, c = n * a, h = r * u, p = r * a, d = i * a, v = s * o, m = s * u, g = s * a;
			        return e[0] = 1 - (h + d), e[3] = l + g, e[6] = c - m, e[1] = l - g, e[4] = 1 - (f + d), e[7] = p + v, e[2] = c + m, e[5] = p - v, e[8] = 1 - (f + h), e;
			    }, t.normalFromMat4 = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = t[4], u = t[5], a = t[6], f = t[7], l = t[8], c = t[9], h = t[10], p = t[11], d = t[12], v = t[13], m = t[14], g = t[15], y = n * u - r * o, b = n * a - i * o, w = n * f - s * o, E = r * a - i * u, S = r * f - s * u, x = i * f - s * a, T = l * v - c * d, N = l * m - h * d, C = l * g - p * d, k = c * m - h * v, L = c * g - p * v, A = h * g - p * m, O = y * A - b * L + w * k + E * C - S * N + x * T;
			        return O ? (O = 1 / O, e[0] = (u * A - a * L + f * k) * O, e[1] = (a * C - o * A - f * N) * O, e[2] = (o * L - u * C + f * T) * O, e[3] = (i * L - r * A - s * k) * O, e[4] = (n * A - i * C + s * N) * O, e[5] = (r * C - n * L - s * T) * O, e[6] = (v * x - m * S + g * E) * O, e[7] = (m * w - d * x - g * b) * O, e[8] = (d * S - v * w + g * y) * O, e) : null;
			    }, t.str = function(e) {
			        return "mat3(" + e[0] + ", " + e[1] + ", " + e[2] + ", " + e[3] + ", " + e[4] + ", " + e[5] + ", " + e[6] + ", " + e[7] + ", " + e[8] + ")";
			    }, t;
			}), define("UXTIupZGRczsgnUj2SpAlCuuFJw3p3TtznLNsAamIcQ=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=" ], function(e, t) {
			    "use strict";
			    var n = {};
			    return n.create = function() {
			        var t = e.createFloatArray(4);
			        return t[0] = 0, t[1] = 0, t[2] = 0, t[3] = 0, t;
			    }, n.clone = function(t) {
			        var n = e.createFloatArray(4);
			        return n[0] = t[0], n[1] = t[1], n[2] = t[2], n[3] = t[3], n;
			    }, n.fromValues = function(t, n, r, i) {
			        var s = e.createFloatArray(4);
			        return s[0] = t, s[1] = n, s[2] = r, s[3] = i, s;
			    }, n.copy = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e[2] = t[2], e[3] = t[3], e;
			    }, n.set = function(e, t, n, r, i) {
			        return e[0] = t, e[1] = n, e[2] = r, e[3] = i, e;
			    }, n.add = function(e, t, n) {
			        return e[0] = t[0] + n[0], e[1] = t[1] + n[1], e[2] = t[2] + n[2], e[3] = t[3] + n[3], e;
			    }, n.subtract = function(e, t, n) {
			        return e[0] = t[0] - n[0], e[1] = t[1] - n[1], e[2] = t[2] - n[2], e[3] = t[3] - n[3], e;
			    }, n.sub = n.subtract, n.multiply = function(e, t, n) {
			        return e[0] = t[0] * n[0], e[1] = t[1] * n[1], e[2] = t[2] * n[2], e[3] = t[3] * n[3], e;
			    }, n.mul = n.multiply, n.divide = function(e, t, n) {
			        return e[0] = t[0] / n[0], e[1] = t[1] / n[1], e[2] = t[2] / n[2], e[3] = t[3] / n[3], e;
			    }, n.div = n.divide, n.min = function(e, t, n) {
			        return e[0] = Math.min(t[0], n[0]), e[1] = Math.min(t[1], n[1]), e[2] = Math.min(t[2], n[2]), e[3] = Math.min(t[3], n[3]), e;
			    }, n.max = function(e, t, n) {
			        return e[0] = Math.max(t[0], n[0]), e[1] = Math.max(t[1], n[1]), e[2] = Math.max(t[2], n[2]), e[3] = Math.max(t[3], n[3]), e;
			    }, n.scale = function(e, t, n) {
			        return e[0] = t[0] * n, e[1] = t[1] * n, e[2] = t[2] * n, e[3] = t[3] * n, e;
			    }, n.scaleAndAdd = function(e, t, n, r) {
			        return e[0] = t[0] + n[0] * r, e[1] = t[1] + n[1] * r, e[2] = t[2] + n[2] * r, e[3] = t[3] + n[3] * r, e;
			    }, n.distance = function(e, t) {
			        var n = t[0] - e[0], r = t[1] - e[1], i = t[2] - e[2], s = t[3] - e[3];
			        return Math.sqrt(n * n + r * r + i * i + s * s);
			    }, n.dist = n.distance, n.squaredDistance = function(e, t) {
			        var n = t[0] - e[0], r = t[1] - e[1], i = t[2] - e[2], s = t[3] - e[3];
			        return n * n + r * r + i * i + s * s;
			    }, n.sqrDist = n.squaredDistance, n.length = function(e) {
			        var t = e[0], n = e[1], r = e[2], i = e[3];
			        return Math.sqrt(t * t + n * n + r * r + i * i);
			    }, n.len = n.length, n.squaredLength = function(e) {
			        var t = e[0], n = e[1], r = e[2], i = e[3];
			        return t * t + n * n + r * r + i * i;
			    }, n.sqrLen = n.squaredLength, n.negate = function(e, t) {
			        return e[0] = -t[0], e[1] = -t[1], e[2] = -t[2], e[3] = -t[3], e;
			    }, n.normalize = function(e, t) {
			        var n = t[0], r = t[1], i = t[2], s = t[3], o = n * n + r * r + i * i + s * s;
			        return o > 0 && (o = 1 / Math.sqrt(o), e[0] = t[0] * o, e[1] = t[1] * o, e[2] = t[2] * o, e[3] = t[3] * o), e;
			    }, n.dot = function(e, t) {
			        return e[0] * t[0] + e[1] * t[1] + e[2] * t[2] + e[3] * t[3];
			    }, n.lerp = function(e, t, n, r) {
			        var i = t[0], s = t[1], o = t[2], u = t[3];
			        return e[0] = i + r * (n[0] - i), e[1] = s + r * (n[1] - s), e[2] = o + r * (n[2] - o), e[3] = u + r * (n[3] - u), e;
			    }, n.random = function(e, r) {
			        return r = r || 1, e[0] = t.random(), e[1] = t.random(), e[2] = t.random(), e[3] = t.random(), n.normalize(e, e), n.scale(e, e, r), e;
			    }, n.transformMat4 = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = t[3];
			        return e[0] = n[0] * r + n[4] * i + n[8] * s + n[12] * o, e[1] = n[1] * r + n[5] * i + n[9] * s + n[13] * o, e[2] = n[2] * r + n[6] * i + n[10] * s + n[14] * o, e[3] = n[3] * r + n[7] * i + n[11] * s + n[15] * o, e;
			    }, n.transformQuat = function(e, t, n) {
			        var r = t[0], i = t[1], s = t[2], o = n[0], u = n[1], a = n[2], f = n[3], l = f * r + u * s - a * i, c = f * i + a * r - o * s, h = f * s + o * i - u * r, p = -o * r - u * i - a * s;
			        return e[0] = l * f + p * -o + c * -a - h * -u, e[1] = c * f + p * -u + h * -o - l * -a, e[2] = h * f + p * -a + l * -u - c * -o, e;
			    }, n.forEach = function() {
			        var e = n.create();
			        return function(t, n, r, i, s, o) {
			            var u, a;
			            n || (n = 4), r || (r = 0), i ? a = Math.min(i * n + r, t.length) : a = t.length;
			            for (u = r; u < a; u += n) e[0] = t[u], e[1] = t[u + 1], e[2] = t[u + 2], e[3] = t[u + 3], s(e, e, o), t[u] = e[0], t[u + 1] = e[1], t[u + 2] = e[2], t[u + 3] = e[3];
			            return t;
			        };
			    }(), n.str = function(e) {
			        return "vec4(" + e[0] + ", " + e[1] + ", " + e[2] + ", " + e[3] + ")";
			    }, n;
			}), define("97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=" ], function(e) {
			    "use strict";
			    var t = {};
			    t.FLOAT_EPSILON = 1e-6, t.random = Math.random;
			    if (e.hasFloatArraySupport()) {
			        var n = e.createFloatArray(1), r = e.Int32Array.create(n.buffer);
			        t.invsqrt = function(e) {
			            var t = e * .5;
			            n[0] = e;
			            var s = 1.5;
			            r[0] = 1597463007 - (r[0] >> 1);
			            var o = n[0];
			            return o * (s - t * o * o);
			        };
			    } else t.invsqrt = function(e) {
			        return 1 / Math.sqrt(e);
			    };
			    return t.clamp = function(e, t, n) {
			        return e < t ? t : e > n ? n : e;
			    }, t.isInInterval = function(e, t, n) {
			        return e >= t && e <= n;
			    }, t.modulo = function(e, t) {
			        var n = e % t;
			        return n < 0 ? (n + t) % t : n;
			    }, t.sign = function(e) {
			        return e >= 0 ? 1 : -1;
			    }, t.roundToResolution = function(e, t) {
			        t || (t = .5);
			        var n = e % t;
			        return e - n + (n > t / 2 ? t : 0);
			    }, t.isPointInRect = function(e, t, n, r, i) {
			        var s = i, o = Math.cos(s), u = Math.sin(s), a = t[0] - n / 2, f = t[0] + n / 2, l = t[1] - r / 2, c = t[1] + r / 2, h = t[0] + o * (e[0] - t[0]) - u * (e[1] - t[1]), p = t[1] + u * (e[0] - t[0]) + o * (e[1] - t[1]);
			        return a <= h && h <= f && l <= p && p <= c;
			    }, t.mat3Ortho = function(e, t, n, r, i) {
			        var s = n - t, o = i - r;
			        return e[0] = 2 / s, e[1] = 0, e[2] = 0, e[3] = 0, e[4] = 2 / o, e[5] = 0, e[6] = -(t + n) / s, e[7] = -(i + r) / o, e[8] = 1, e;
			    }, t;
			}), define("Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", [ "9j5YbzgCjvaUn4tlE8fL6F5Uj/eoNIWP1ooU7TsRiWE=", "bA23bDq8fPntmQU9GQoK9B4kAtIeuQjrthbYTL8lteQ=", "qcyBA6HTO/9GIJrM+92UIh/6/k62unY2OILgACwxGT8=", "O0VUNb7eHdfy7Zk77vE6arREreHH14vpCkPPQ1yVsWI=", "kPqicgHkZUNtccahT1HPrc/4aVLyUwv+cXaSLpXJHxo=" ], function(e, t, n, r, i) {
			    "use strict";
			    return {
			        createFloatArray: e,
			        hasFloatArraySupport: t,
			        Int8Array: n,
			        Int32Array: r,
			        Time: i
			    };
			}), define("XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=", [ "Bg0Jxf/FOFpaMG2mDXQQWwVCIW/Q7ZP6IUmOkwio2cE=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=" ], function(e, t) {
			    "use strict";
			    var n = {};
			    return n.create = function() {
			        var t = e.createFloatArray(2);
			        return t[0] = 0, t[1] = 0, t;
			    }, n.clone = function(t) {
			        var n = e.createFloatArray(2);
			        return n[0] = t[0], n[1] = t[1], n;
			    }, n.fromValues = function(t, n) {
			        var r = e.createFloatArray(2);
			        return r[0] = t, r[1] = n, r;
			    }, n.copy = function(e, t) {
			        return e[0] = t[0], e[1] = t[1], e;
			    }, n.set = function(e, t, n) {
			        return e[0] = t, e[1] = n, e;
			    }, n.add = function(e, t, n) {
			        return e[0] = t[0] + n[0], e[1] = t[1] + n[1], e;
			    }, n.subtract = function(e, t, n) {
			        return e[0] = t[0] - n[0], e[1] = t[1] - n[1], e;
			    }, n.sub = n.subtract, n.multiply = function(e, t, n) {
			        return e[0] = t[0] * n[0], e[1] = t[1] * n[1], e;
			    }, n.mul = n.multiply, n.divide = function(e, t, n) {
			        return e[0] = t[0] / n[0], e[1] = t[1] / n[1], e;
			    }, n.div = n.divide, n.min = function(e, t, n) {
			        return e[0] = Math.min(t[0], n[0]), e[1] = Math.min(t[1], n[1]), e;
			    }, n.max = function(e, t, n) {
			        return e[0] = Math.max(t[0], n[0]), e[1] = Math.max(t[1], n[1]), e;
			    }, n.scale = function(e, t, n) {
			        return e[0] = t[0] * n, e[1] = t[1] * n, e;
			    }, n.scaleAndAdd = function(e, t, n, r) {
			        return e[0] = t[0] + n[0] * r, e[1] = t[1] + n[1] * r, e;
			    }, n.distance = function(e, t) {
			        var n = t[0] - e[0], r = t[1] - e[1];
			        return Math.sqrt(n * n + r * r);
			    }, n.dist = n.distance, n.squaredDistance = function(e, t) {
			        var n = t[0] - e[0], r = t[1] - e[1];
			        return n * n + r * r;
			    }, n.sqrDist = n.squaredDistance, n.length = function(e) {
			        var t = e[0], n = e[1];
			        return Math.sqrt(t * t + n * n);
			    }, n.len = n.length, n.squaredLength = function(e) {
			        var t = e[0], n = e[1];
			        return t * t + n * n;
			    }, n.sqrLen = n.squaredLength, n.negate = function(e, t) {
			        return e[0] = -t[0], e[1] = -t[1], e;
			    }, n.normalize = function(e, t) {
			        var n = t[0], r = t[1], i = n * n + r * r;
			        return i > 0 && (i = 1 / Math.sqrt(i), e[0] = t[0] * i, e[1] = t[1] * i), e;
			    }, n.dot = function(e, t) {
			        return e[0] * t[0] + e[1] * t[1];
			    }, n.cross = function(e, t, n) {
			        var r = t[0] * n[1] - t[1] * n[0];
			        return e[0] = e[1] = 0, e[2] = r, e;
			    }, n.lerp = function(e, t, n, r) {
			        var i = t[0], s = t[1];
			        return e[0] = i + r * (n[0] - i), e[1] = s + r * (n[1] - s), e;
			    }, n.random = function(e, n) {
			        n = n || 1;
			        var r = t.random() * 2 * Math.PI;
			        return e[0] = Math.cos(r) * n, e[1] = Math.sin(r) * n, e;
			    }, n.transformMat2 = function(e, t, n) {
			        var r = t[0], i = t[1];
			        return e[0] = n[0] * r + n[2] * i, e[1] = n[1] * r + n[3] * i, e;
			    }, n.transformMat2d = function(e, t, n) {
			        var r = t[0], i = t[1];
			        return e[0] = n[0] * r + n[2] * i + n[4], e[1] = n[1] * r + n[3] * i + n[5], e;
			    }, n.transformMat3 = function(e, t, n) {
			        var r = t[0], i = t[1];
			        return e[0] = n[0] * r + n[3] * i + n[6], e[1] = n[1] * r + n[4] * i + n[7], e;
			    }, n.transformMat4 = function(e, t, n) {
			        var r = t[0], i = t[1];
			        return e[0] = n[0] * r + n[4] * i + n[12], e[1] = n[1] * r + n[5] * i + n[13], e;
			    }, n.forEach = function() {
			        var e = n.create();
			        return function(t, n, r, i, s, o) {
			            var u, a;
			            n || (n = 2), r || (r = 0), i ? a = Math.min(i * n + r, t.length) : a = t.length;
			            for (u = r; u < a; u += n) e[0] = t[u], e[1] = t[u + 1], s(e, e, o), t[u] = e[0], t[u + 1] = e[1];
			            return t;
			        };
			    }(), n.str = function(e) {
			        return "vec2(" + e[0] + ", " + e[1] + ")";
			    }, n;
			}), define("GoL+ord+9gG/CZr2Vm4ab0dKMLT/P0WQNG8szm46sIs=", [ "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=" ], function(e) {
			    "use strict";
			    var t = e.create(), n = e.create(), r = e.create(), i = function(e, i, s, o, u, a, f, l) {
			        return t[0] = s.x - f, t[1] = s.y, n[0] = o - f, n[1] = u - l, r[0] = s.width + f * 2, r[1] = s.height + l * 2, e.drawSubTexture(i, t, r, n, r), s.width + a + f;
			    }, s = function(e, t, n, r) {
			        r = t.config.hSpacing + r;
			        if (!n) return 0;
			        var i = 0, s = e.length, o = t.config.charset;
			        if (n === "left") return i;
			        if (n === "right") return i;
			        if (n === "center") {
			            for (var u = 0; u < s; u++) {
			                var a = o[e.charAt(u)];
			                a || (a = o[" "]), i += a.width + r;
			            }
			            return i * .5;
			        }
			    };
			    return function(e, t, n, r, o, u, a, f) {
			        a = a || 0, u = u.toString(), r -= s(u, t, f, a);
			        var l = u.length, c = t.config.charset, h = t.config.hSpacing, p = t.config.vSpacing;
			        for (var d = 0; d < l; d++) {
			            var v = c[u.charAt(d)];
			            v || (v = c[" "]), r += i(e, n, v, r, o, a, h, p);
			        }
			    };
			}), define("wnAnBa/NAGRTURzVFy/y3DjKuL9AnnG5zN1Jjft7iwM=", [ "GoL+ord+9gG/CZr2Vm4ab0dKMLT/P0WQNG8szm46sIs=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=", "UXTIupZGRczsgnUj2SpAlCuuFJw3p3TtznLNsAamIcQ=", "yVWG+StUPY2cpL5TJDIz/GlQdjOt3yQROd6W8z+bGks=" ], function(e, t, n, r, i) {
			    "use strict";
			    var s = i.identity(i.create()), o = n.create(), u = .5, a = r.fromValues(.4, .4, .4, u), f = r.fromValues(.7, .7, .7, u), l = r.fromValues(0, 0, .7, u), c = r.fromValues(0, .7, 0, u), h = function(e) {
			        var t = Math.log(e) / Math.log(10), n = Math.round(t);
			        return Math.pow(10, n - 1);
			    }, p = function(e, t) {
			        var n = e % t;
			        return n !== 0 ? e > 0 ? e - n + t : e - n : e;
			    }, d = function(e, t) {
			        return Math.floor(e / t);
			    }, v = function(t, n, r, i, s, o, u, l, h, p) {
			        var d = s * 10, v = Math.round((u + h[1]) * l), m, g;
			        for (var y = 0; y <= p; y++) g = o + y * s, m = Math.round((g + h[0]) * l), t.setColor(g === 0 ? c : g % d === 0 ? f : a), t.fillRect(m, v, 1, i), e(t, n, r, m + 3, v, g);
			    }, m = function(t, n, r, i, s, o, u, c, h, p) {
			        var d = s * 10, v = Math.round((u + h[0]) * c), m, g;
			        for (var y = 0; y <= p; y++) g = o + y * s, m = Math.round((g + h[1]) * c), t.setColor(g === 0 ? l : g % d === 0 ? f : a), t.fillRect(v, m, i, 1), e(t, n, r, v + 3, m, g);
			    };
			    return function(e, r, i, u, a) {
			        var f = a.translation, l = u[0], c = u[1], g = f[0] - l / 2, y = f[1] - c / 2, b = g + l, w = y + c, E = h(l), S = [ -g, -y ], x = r.resource;
			        n.divide(o, i, u), e.save(), t.mat3Ortho(s, 0, i[0], 0, i[1]), e.setViewMatrix(s), v(e, r, x, i[1], E, p(g, E), y, o[1], S, d(l, E)), m(e, r, x, i[0], E, p(y, E), g, o[0], S, d(c, E)), e.restore();
			    };
			}), define("i9MLdMDkxbtBR2CZHJFclZiJU/kTPDaefQqSH5elN5Q=", function() {
			    "use strict";
			    return function(e, t) {
			        t || (t = 1), e.drawLine(-t, -t, t, t), e.drawLine(-t, t, t, -t);
			    };
			}), define("4SIYpLzIVb2YGd/OG/bAB2/geQyHSeWfbS1su39XCx0=", function() {
			    "use strict";
			    return function(e, t) {
			        t || (t = 1);
			        var n = 2 * t, r = n * .5;
			        e.fillRect(-r, -r, n, n);
			    };
			}), define("RjLlAfI5Vltng0Gnpb8aWiK65lgRpFMj6tAtBypaimw=", function() {
			    "use strict";
			    return function(e, t, n, r) {
			        var i = t * -.5;
			        e.setLineColor(n), e.drawCircle(0, 0, t, r), e.drawLine(t, 0, t * .618, 0, r);
			    };
			}), define("RYbxb+1mO6iMdLJEUnOrOauSypye4XjcD3Isw0wfQVQ=", function() {
			    "use strict";
			    return function(e, t, n, r, i) {
			        var s = t * .5, o = n * .5;
			        e.setLineColor(r), e.drawRect(-s, -o, t, n, i), e.drawLine(s * .618, 0, s, 0, i);
			    };
			}), define("ar2HFFlGQ5PtmMGV2FiBZmOyBRr8awCdXvff4wAbgo0=", function() {
			    "use strict";
			    return {
			        rectangle: function(e, t) {
			            var n = t.width, r = t.height, i = n * -.5, s = r * -.5;
			            t.fill && (e.setColor(t.fillColor), e.fillRect(i, s, n, r)), e.setLineColor(t.lineColor), e.drawRect(i, s, n, r, t.lineWidth);
			        }
			    };
			}), define("IB9jfUoKNrdRjZqEIu7wNHEnyBRP4i1RaGStmBOiBQQ=", [ "ar2HFFlGQ5PtmMGV2FiBZmOyBRr8awCdXvff4wAbgo0=", "RYbxb+1mO6iMdLJEUnOrOauSypye4XjcD3Isw0wfQVQ=", "RjLlAfI5Vltng0Gnpb8aWiK65lgRpFMj6tAtBypaimw=", "4SIYpLzIVb2YGd/OG/bAB2/geQyHSeWfbS1su39XCx0=", "i9MLdMDkxbtBR2CZHJFclZiJU/kTPDaefQqSH5elN5Q=", "wnAnBa/NAGRTURzVFy/y3DjKuL9AnnG5zN1Jjft7iwM=", "4vsnWAiE5zSFrXpOOZ2hdE2ZexQK0X61B2rw4N6SvLs=", "DL2XO5bR2mezFB5wDHhPp+WUMECQNrIMAg+5DYokByc=", "UPOGxICBwHHAJnhEO0kYe4CbSZksrC7moXiy6Wgb0MM=", "wmv6Nu5PrhR2GBQseWUtsQS+j5FlMm6CQ794XX3Cd9A=", "yVWG+StUPY2cpL5TJDIz/GlQdjOt3yQROd6W8z+bGks=", "9h1VbSkUkR0rOE8ony/LEvlqT9hawoj6Npu6TdQx4pI=", "HCQLCqor0eV+DAO4JM25Frq5bQkCpQpTDQEHtpXy9ag=", "97QSKdFRX0w37qbL3KqhfQrCAv7uhiVQnnchaRbQLpk=", "XkHHuWc5juwWekXa4T8qrEaFSxzgKdm3364FC6cx4Co=", "a6QMpZpC/oS8xcSHem/guTKp+NBdWdqqxoayLw/oN8Y=", "UXTIupZGRczsgnUj2SpAlCuuFJw3p3TtznLNsAamIcQ=", "dunF+D1VptGh1mvT/vo4D+cQh7io0eKZgvwrqCjcMow=", "AE4JV5gWwq3FE9WsQybF29eg05JxvOqTmiHIZrNKCR0=", "qK33jL/Mq7B5Vu6fbGS3/sPc0C/aQisKbAMhYhm3OJk=", "2JM90K4OxW6bfbnvH9gYnm0kSJxaAvTFlf59uaLcTnY=", "Njtu1p/lIocQu9jigRUr61eNAmO/ZIR7GBcFv6RVQkk=", "vV8JUbcAFKwRw0kj9C+z03trX9WutPyp4SJONZGPilU=", "RtIYVMl7NLjPEVfGOmP5fh9Nx6lTDT9M9H4kPYDCldY=", "z7TX6BsmUcv0nH/bqr0j7VkT7tQUPxwYZT67+lzEXGk=", "Vsylc/NMToQHW836UwRyCRPN84V2NddLsPHwdwldHCE=", "hJb+mSFyVabGetH1ke8dX63PPYPjsoFy4ea4w/GvIxQ=" ], function() {
			    return undefined;
			}), define("ChYbCQykZBon8Ii54rxrAyc7zW54QvlnvqLfW3nPjN0=", [ "1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=", "d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", "rvasITs2FBDcIVclbnPocpNbQvHuu/vr/WHZ0WRVg5s=" ], function(e, t, n) {
			    "use strict";
			    return function(r) {
			        return e({
			            add: function(e) {
			                r.sceneManager.addSystem(e.systemId, e.executionGroupId, e.index, e.systemConfig);
			            },
			            move: function(e) {
			                r.sceneManager.moveSystem(e.systemId, e.srcExecutionGroupId, e.dstExecutionGroupId, e.dstIndex);
			            },
			            remove: function(e) {
			                r.sceneManager.removeSystem(e.systemId, e.executionGroupId);
			            },
			            update: function(e) {
			                var i = e.definition;
			                if (!i.namespace || !i.name) throw "Error: System definition is missing namespace and or name attribute.";
			                var s = t(i.namespace, i.name), o = {};
			                o[n(s)] = i, r.libraryManager.addToCache(o), r.sceneManager.restartSystem(s, e.executionGroupId, e.systemConfig);
			            }
			        });
			    };
			}), define("1rqqQwDriBtxhdpQLfU1QbOSpXNz0qE31+5K46MrYeE=", [ "1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=" ], function(e) {
			    "use strict";
			    return function(t) {
			        return e({
			            drawCoordinateGrid: function(e) {
			                t.configurationManager.setValue("drawCoordinateGrid", e);
			            },
			            drawTitleSafeOutline: function(e) {
			                t.configurationManager.setValue("drawTitleSafeOutline", e);
			            },
			            setScreenMode: function(e) {
			                t.configurationManager.setValue("screenMode", e);
			            },
			            simulateScreenAspectRatio: function(e) {
			                t.configurationManager.setValue("screenAspectRatio", e.aspectRatio);
			            }
			        });
			    };
			}), define("C20TozIGoGYLzcTFVqaYDwSi189PvKkTfxhBjT84cFc=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function(t, n, r, i, s) {
			        if (!r) throw "Error: Missing application module. Please provide a application module.";
			        t.applicationModule = r, n.setConfig(e.extend(i, s));
			    };
			}), define("Zt4dDF5B0lgdwIfuUagRZUHqy70yWlr5e3mCP8+h4ik=", [ "C20TozIGoGYLzcTFVqaYDwSi189PvKkTfxhBjT84cFc=", "1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=" ], function(e, t) {
			    "use strict";
			    return function(n, r) {
			        return t({
			            startApplicationModule: function(e) {
			                r(e.applicationModule);
			            },
			            setApplicationModule: function(t) {
			                e(n, n.configurationManager, t.applicationModule, t.applicationModule.config, n.loaderConfig);
			            },
			            addToCache: function(e) {
			                n.libraryManager.addToCache(e.cacheContent);
			            },
			            startScene: function(e) {
			                n.sceneManager.startScene(e.startSceneId, e.initialConfig, e.showLoadingScene);
			            }
			        });
			    };
			}), define("6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", [ "gJW/lLYgY7GQD3jSIw3KqCfqP7QOzxtAqQKeGMkRgsk=", "Uk05TQbFhLjcnGbdbOPLJdj/vU155EGxAWS+19s4cWU=", "HFDYWVgRyrhHY2KATklGRkPckqV4jVAACe4xWOlbLYY=", "nWNLlTtXESn8SqZ6GddNabDOUjB4LefSiI+9XEsZYmg=", "l9dSFVp1qo6eP3hR340CJSWXAetRnpxaVzMXOT2OcB8=", "Di30uWqRYAwyqAdAxFmRqw86a8D7ltvaWwld3nnR01Q=", "0N5cGXariGqD4N3whA0u6kiS5RWgC/2hQRDInlWP/YE=", "B6cZIUtIjiQAeBHS1O6wHTUXCz5h3Y0N1v4W5ubpfb8=", "KbXW13xQZi+ZmL5T5siHSuWpqYOZ0+3IRsqaL0xh2Vc=", "bT1dgc/3zs3/zhPuJg4Xiztl8XLm5Uc+D+Eqtkbsmd4=", "7lrsAcIJ54z2DGiA+VzPHPCwn4wrYCSbrHjhffGTNvI=", "XqX2t9n50Hfi19mtSZs5LEk42LHNrgz7ttwgdF8R2Wk=", "QaD0f6fU2UVjItxoSDDWeB2ElIaLINNHevlJfzmoDBg=", "XRz6ZY1jo28yLiT686aBwTBcr94D/v97NQM1Ti3dvCQ=", "3ZSQGM1c2BAMKa3dbHQCHrSWm3fXxxnzR+a5MWv/xdg=", "rEYqh2GBvinjduCyGsbv4n9mKgNnKE+azLg9e1q6fUw=", "nBRERbho9PXv7Yc7UKzlz9aYKuD6BeNrhTlfLlHck4o=", "dBVCdOd2ydzpZ+4Sx8Q/uZzh/d0W0UPJ9KIqh5lHd9E=", "bIKOt9oMElIV0GQpgfiDxhZVWRQmgB/hmFxWZVdBfYI=", "dc855VzKbZ3C0uEE8Y0J3EBH7rJisMY0O3dTsUOYRgY=", "a95jtPTulju62VK+PhCeL4cucnRzgLbL8cudeGPnhmI=", "fYiHptkH5stGiIn5lNcC3Ai/0fjnPHWmmHhv/sJJsuY=", "/N66TS4x5oN6xxyJsNRBwLtUixNN3mX6mvW2RfsfciI=", "xVmiSeFJmCkslGulIYb/x2nzuFccj+IFmGIdlCbk9uw=", "XSTM/Mril+TDjU0Gq8YT4SBxjuKlBLva6Qnc2F8EPTE=" ], function(e, t, n, r, i, s, o, u, a, f, l, c, h, p, d, v, m, g, y, b, w, E, S, x, T) {
			    "use strict";
			    var N = function() {
			        return r();
			    }, C = function(e, t) {
			        return new m(e, t);
			    }, k = function(e, t, n) {
			        E(e, t, n);
			    };
			    return {
			        Box2D: t,
			        callNextFrame: n,
			        registerTimer: h,
			        network: {
			            createSocket: s,
			            performHttpRequest: o
			        },
			        AudioFactory: c,
			        RenderingFactory: f,
			        getHost: N,
			        ModuleLoader: a,
			        configurationOptions: g,
			        platformDetails: w,
			        jsonCoder: i,
			        createInput: C,
			        getAvailableScreenSize: u,
			        registerOnScreenResize: k,
			        openURL: b,
			        createPersistentStorage: function() {
			            return new y;
			        },
			        createImageLoader: function(e, t, n, r, i, s) {
			            return new p(e, t, n, r, i, s);
			        },
			        createSoundLoader: function(e, t, n, r, i, s) {
			            return new d(e, t, n, r, i, s);
			        },
			        createTextLoader: function(e, t, n, r, i, s) {
			            return new v(e, t, n, r, i, s);
			        },
			        loadInterstitial: S.loadInterstitial,
			        showInterstitial: S.showInterstitial,
			        flurry: x,
			        createComponentType: T,
			        Application: e,
			        createSplashScreenImage: l
			    };
			}), define("v8fOdhNCtMEZStOrNxspT+wYpcqnI29sSZZku+1iaIw=", function() {
			    "use strict";
			    return function(e) {
			        return e.replace(/\./g, "/");
			    };
			}), define("JPtYE/eGdg4cjudzm8i8oAteuVIDlvZVo7prxFGenWk=", [ "d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", "v8fOdhNCtMEZStOrNxspT+wYpcqnI29sSZZku+1iaIw=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r) {
			    "use strict";
			    var i = function(n, i) {
			        return r.reduce(n.getMetaDataRecordsByType("system"), function(n, s) {
			            var o = e(s.namespace, s.name), u = t(o);
			            return r.contains(i, u) && n.push(o), n;
			        }, []);
			    };
			    return function(e, s) {
			        var o = t(s.id);
			        define(o, s.moduleSource);
			        var u = e.sceneManager, a = i(e.libraryManager, n.ModuleLoader.createDependentModules(o).concat(o));
			        r.each(a, function(e) {
			            u.restartSystem(e);
			        });
			    };
			}), define("g0h4wSYJ6PckMghl1xKoDvvqjXOhL04NgsBPD/EzxEg=", function() {
			    "use strict";
			    return function(e, t) {
			        e.entityManager.updateEntityTemplate(t.definition);
			    };
			}), define("t4YVpmpTWzX1X5zYtdZb+Qx3f48PbPKIu/Z/0trq9ZE=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function(t) {
			        return e.reduce(t, function(e, t) {
			            return e.result[t] = e.index++, e;
			        }, {
			            index: 0,
			            result: {}
			        }).result;
			    };
			}), define("AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", [ "t4YVpmpTWzX1X5zYtdZb+Qx3f48PbPKIu/Z/0trq9ZE=" ], function(e) {
			    "use strict";
			    var t = e([ "SERVER_CONNECTION_ESTABLISHED", "MESSAGE_RECEIVED", "CLOCK_SYNC_ESTABLISHED", "COMPONENT_CREATED", "COMPONENT_UPDATED", "ENTITY_CREATED", "ENTITY_DESTROYED", "ASSET_UPDATED", "ACTION_STARTED", "ACTION_STOPPED", "SUBSCRIBE", "UNSUBSCRIBE", "RESOURCE_PROGRESS", "RESOURCE_LOADING_COMPLETED", "RESOURCE_ERROR", "KEY_DOWN", "KEY_UP", "RENDER_UPDATE", "LOGIC_UPDATE", "CREATE_SCENE", "DESTROY_SCENE", "AVAILABLE_SCREEN_SIZE_CHANGED", "SCREEN_RESIZE" ]);
			    return t.getNameById = function(e) {
			        for (var n in t) {
			            var r = t[n];
			            if (e === r) return n;
			        }
			    }, t;
			}), define("rvasITs2FBDcIVclbnPocpNbQvHuu/vr/WHZ0WRVg5s=", function() {
			    "use strict";
			    return function(e) {
			        return e.replace(/\./g, "/") + ".json";
			    };
			}), define("Njtu1p/lIocQu9jigRUr61eNAmO/ZIR7GBcFv6RVQkk=", function() {
			    return {
			        BACKSPACE: 8,
			        TAB: 9,
			        ENTER: 13,
			        SHIFT: 16,
			        CTRL: 17,
			        ALT: 18,
			        PAUSE: 19,
			        CAPS_LOCK: 20,
			        ESCAPE: 27,
			        SPACE: 32,
			        PAGE_UP: 33,
			        PAGE_DOWN: 34,
			        END: 35,
			        HOME: 36,
			        LEFT_ARROW: 37,
			        UP_ARROW: 38,
			        RIGHT_ARROW: 39,
			        DOWN_ARROW: 40,
			        INSERT: 45,
			        DELETE: 46,
			        0: 48,
			        1: 49,
			        2: 50,
			        3: 51,
			        4: 52,
			        5: 53,
			        6: 54,
			        7: 55,
			        8: 56,
			        9: 57,
			        A: 65,
			        B: 66,
			        C: 67,
			        D: 68,
			        E: 69,
			        F: 70,
			        G: 71,
			        H: 72,
			        I: 73,
			        J: 74,
			        K: 75,
			        L: 76,
			        M: 77,
			        N: 78,
			        O: 79,
			        P: 80,
			        Q: 81,
			        R: 82,
			        S: 83,
			        T: 84,
			        U: 85,
			        V: 86,
			        W: 87,
			        X: 88,
			        Y: 89,
			        Z: 90,
			        LEFT_WINDOW_KEY: 91,
			        RIGHT_WINDOW_KEY: 92,
			        SELECT_KEY: 93,
			        NUMPAD_0: 96,
			        NUMPAD_1: 97,
			        NUMPAD_2: 98,
			        NUMPAD_3: 99,
			        NUMPAD_4: 100,
			        NUMPAD_5: 101,
			        NUMPAD_6: 102,
			        NUMPAD_7: 103,
			        NUMPAD_8: 104,
			        NUMPAD_9: 105,
			        MULTIPLY: 106,
			        ADD: 107,
			        SUBTRACT: 109,
			        DECIMAL_POINT: 110,
			        DIVIDE: 111,
			        F1: 112,
			        F2: 113,
			        F3: 114,
			        F4: 115,
			        F5: 116,
			        F6: 117,
			        F7: 118,
			        F8: 119,
			        F9: 120,
			        F10: 121,
			        F11: 122,
			        F12: 123,
			        NUM_LOCK: 144,
			        SCROLL_LOCK: 145,
			        "SEMI-COLON": 186,
			        EQUAL_SIGN: 187,
			        COMMA: 188,
			        DASH: 189,
			        PERIOD: 190,
			        FORWARD_SLASH: 191,
			        GRAVE_ACCENT: 192,
			        OPEN_BRACKET: 219,
			        BACK_SLASH: 220,
			        CLOSE_BRACKET: 221,
			        SINGLE_QUOTE: 222,
			        ANDROID_BACK: 230
			    };
			}), define("d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function(t) {
			        var n = arguments.length;
			        n === 1 ? e.isArray(t) || (t = [ t ]) : n > 1 && (t = e.toArray(arguments));
			        if (!t || t.length === 0) throw "Error: Missing name and or namespace.";
			        return e.reduce(t, function(e, t) {
			            return t === "" ? e : e + (e !== "" ? "." : "") + t;
			        }, "");
			    };
			}), define("JscvW/UOc/LPuKzvXkfy4LGmZU+VdMCIs3LRZD33Ecg=", [ "d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t) {
			    "use strict";
			    return function(n) {
			        if (!n) throw "Error: Missing argument 'scheme'.";
			        return n + ":" + e(t.toArray(arguments).slice(1));
			    };
			}), define("ingT4RnRpUiJVUpqmIZzn0mb4bWOxvdCL7jVnvrEevs=", [ "JscvW/UOc/LPuKzvXkfy4LGmZU+VdMCIs3LRZD33Ecg=", "bFOXtEjmXJ1lK4AExMZNtVOOBi6q4Gj93XmA7N0camQ=", "Njtu1p/lIocQu9jigRUr61eNAmO/ZIR7GBcFv6RVQkk=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r) {
			    "use strict";
			    var i = function(e, t, n, r, i, s) {
			        return s || (s = 0), e += s * 2, t += s * 2, [ i % n * e + s, Math.floor(i / n) * t + s ];
			    }, s = function(e, t) {
			        var n = t.assetId, r = e.get(n);
			        if (!r) return;
			        return {
			            type: t.subtype,
			            resourceId: r.resourceId,
			            spriteSheet: r,
			            config: t.config,
			            tilemapDimensions: [ t.config.width, t.config.height ],
			            tilemapData: t.config.tileLayerData
			        };
			    }, o = function(e, t) {
			        var n = t.assetId, s = e.get(n);
			        if (!s) return;
			        var o = s.config.frameWidth, u = s.config.frameHeight, a = s.config.innerPadding || 0, f = Math.floor(s.config.textureWidth / (o + a * 2)), l = Math.floor(s.config.textureHeight / (u + a * 2)), c = r.size(t.config.frameIds), h = r.bind(i, null, o, u);
			        return {
			            type: t.subtype,
			            resourceId: s.resourceId,
			            frameDimensions: [ o, u ],
			            frameDuration: t.config.duration / c,
			            frameOffsets: r.map(t.config.frameIds, function(e) {
			                return h(f, l, e, a);
			            }),
			            numFrames: c
			        };
			    }, u = function(e) {
			        return r.reduce(e.config, function(e, t, r) {
			            return e[n[r]] = t, e;
			        }, {});
			    }, a = function(e, t) {
			        return r.each(e, function(e) {
			            r.each(e, t);
			        });
			    }, f = function(e) {
			        var t = e.config;
			        return a(t.animate, function(e) {
			            e.length = r.last(e.keyFrames).time;
			        }), {
			            animate: t.animate,
			            type: e.subtype,
			            length: t.length
			        };
			    }, l = function(e) {
			        var t = e.config.frameWidth, n = e.config.frameHeight, r = e.config.innerPadding || 0, s = Math.floor(e.config.textureWidth / (t + r * 2)), o = Math.floor(e.config.textureHeight / (n + r * 2)), u = s * o, a = [], f = [];
			        for (var l = 0; l < u; l++) a[l] = i(t, n, s, o, l, r), f[l] = l;
			        return {
			            frameDimensions: [ t, n ],
			            frames: f,
			            frameOffsets: a,
			            frameMaxX: s,
			            frameMaxY: o,
			            numFrames: u,
			            config: e.config,
			            type: e.subtype
			        };
			    }, c = function(e, n) {
			        var r = n.file;
			        if (!r) return;
			        e.resourceId = t(n.namespace, r);
			    };
			    return function(t, n, i) {
			        var a = i ? n : r.filter(n, function(n) {
			            return !t.has(e(n.subtype, n.namespace, n.name));
			        });
			        r.each(a, function(n) {
			            var r, i = n.subtype, s = e(i, n.namespace, n.name);
			            i === "appearance" || i === "sound" ? r = {
			                type: i
			            } : i === "spriteSheet" ? r = l(n) : i === "font" ? r = {
			                config: n.config,
			                type: i
			            } : i === "keyToActionMap" ? r = u(n) : i === "keyFrameAnimation" ? r = f(n) : i === "translation" && (r = {
			                config: n.config,
			                type: i
			            }), c(r, n), r && (r.assetId = s), t.add(s, r);
			        }), r.each(n, function(n) {
			            var r = n.subtype;
			            if (r === "animation") {
			                var i = o(t, n);
			                i && t.add(e(r, n.namespace, n.name), i);
			            } else if (r === "2dTileMap") {
			                var u = s(t, n);
			                u && t.add(e(r, n.namespace, n.name), u);
			            }
			        });
			    };
			}), define("+kMCuNhMJbCFFz81NxZMk0B1yxR7pTV+H67Y6qVKnvY=", function() {
			    "use strict";
			    return function(e, t) {
			        if (!t.resourceId) return;
			        var n = e.get(t.resourceId);
			        if (!n) return;
			        t.resource = n;
			    };
			}), define("bFOXtEjmXJ1lK4AExMZNtVOOBi6q4Gj93XmA7N0camQ=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function(e, t) {
			        return e.replace(/\./g, "/") + "/" + t;
			    };
			}), define("3NNm1Xr+NiUMHZ6h4rjokfmOhn1qi0l9m+2oT/bl0aI=", [ "bFOXtEjmXJ1lK4AExMZNtVOOBi6q4Gj93XmA7N0camQ=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t) {
			    "use strict";
			    return function(n, r) {
			        var i = n.getValue("currentLanguage");
			        return t.unique(t.reduce(r, function(t, n) {
			            if (!n.file) return t;
			            var r;
			            if (n.config && n.config.localized) {
			                var s = n.file, o = s.substr(s.lastIndexOf(".") + 1), u = n.name + "." + i + "." + o;
			                r = {
			                    libraryPath: e(n.namespace, n.file),
			                    libraryPathUrlUsedForLoading: e(n.namespace, u)
			                };
			            } else r = e(n.namespace, n.file);
			            return t.concat(r);
			        }, []));
			    };
			}), define("u5BpngAz0+tckzBYKX+WqMrwRbSFVWFZXgiyYvS/F9Y=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    return function(e, t) {
			        var n = e.substr(0, e.length - 5);
			        return t ? n.split("/") : n.replace(/\//g, ".");
			    };
			}), define("UDKOzFuhCFMgpnBYA5n7LsFCrO6xRaePEI2Hi2gAn6I=", [ "u5BpngAz0+tckzBYKX+WqMrwRbSFVWFZXgiyYvS/F9Y=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t) {
			    "use strict";
			    var n = function(n) {
			        t.each(n, function(t, n) {
			            var r = e(n, !0);
			            t.name = r.pop(), t.namespace = r.join(".");
			        });
			    };
			    return n;
			}), define("R53a2CoCf6ZWQXb0vgxuKSv7SedOWMWlQjMyqths10o=", [ "UDKOzFuhCFMgpnBYA5n7LsFCrO6xRaePEI2Hi2gAn6I=", "3NNm1Xr+NiUMHZ6h4rjokfmOhn1qi0l9m+2oT/bl0aI=", "+kMCuNhMJbCFFz81NxZMk0B1yxR7pTV+H67Y6qVKnvY=", "ingT4RnRpUiJVUpqmIZzn0mb4bWOxvdCL7jVnvrEevs=", "JscvW/UOc/LPuKzvXkfy4LGmZU+VdMCIs3LRZD33Ecg=", "d0kh+S/Mnugahpa7NEEeOTSkLpvFA8csYgM4qOYvZS0=", "bFOXtEjmXJ1lK4AExMZNtVOOBi6q4Gj93XmA7N0camQ=", "rvasITs2FBDcIVclbnPocpNbQvHuu/vr/WHZ0WRVg5s=", "AHznaobFqalp2i3u1DutC/Z4nV5oIF9wXHFZ6WRB9v4=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s, o, u, a, f) {
			    "use strict";
			    return function(n, l) {
			        var c = n.assetManager, h = n.configurationManager, p = l.definition, d = s(p.namespace, p.name), v = i(p.subtype, d), m = u(d), g = {};
			        g[m] = p, e(g), !p.file && !p.assetId && (r(c, g, !0), n.eventManager.publish([ a.ASSET_UPDATED, p.subtype ], [ v ])), p.file && n.libraryManager.load(t(h, g), {
			            isMetaDataLoad: !1,
			            omitCache: !0,
			            onLoadingCompleted: function(e) {
			                r(c, g, !0), n.libraryManager.addToCache(g);
			                var t = c.getLibraryIdByResourceId(o(p.namespace, p.file)), i = f.reduce(t, function(e, t) {
			                    var r = u(t);
			                    return e[r] = n.libraryManager.get(r), e;
			                }, {});
			                r(c, i, !0), c.injectResources(e), n.entityManager.refreshAssetReferences(c), n.eventManager.publish([ a.ASSET_UPDATED, p.subtype ], [ v ]);
			            }
			        });
			        if (p.assetId) {
			            var y = p.assetId;
			            n.libraryManager.load([ u(y.slice(y.indexOf(":") + 1)) ], {
			                omitCache: !0,
			                onLoadingCompleted: function(e) {
			                    r(c, e), n.libraryManager.load(t(h, e), {
			                        isMetaDataLoad: !1,
			                        omitCache: !0,
			                        onLoadingCompleted: function(e) {
			                            r(c, g, !0), c.injectResources(e), n.entityManager.updateAssetReferences(v, c.get(v)), n.eventManager.publish([ a.ASSET_UPDATED, p.subtype ], [ v ]);
			                        }
			                    });
			                }
			            });
			        }
			    };
			}), define("CIb1nJXpKt9CP41s6SRsDATeI6HHJLUDIDiadaxfLaQ=", [ "1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=", "R53a2CoCf6ZWQXb0vgxuKSv7SedOWMWlQjMyqths10o=", "g0h4wSYJ6PckMghl1xKoDvvqjXOhL04NgsBPD/EzxEg=", "JPtYE/eGdg4cjudzm8i8oAteuVIDlvZVo7prxFGenWk=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i) {
			    "use strict";
			    return function(s) {
			        return e({
			            updateAsset: i.bind(t, null, s),
			            updateEntityTemplate: i.bind(n, null, s),
			            updateScript: i.bind(r, null, s)
			        });
			    };
			}), define("yK0eyZyMwZiwjPdm7fwzZv0BMUD7E0HxS/8Ny9G525k=", [ "1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=" ], function(e) {
			    "use strict";
			    return function(t) {
			        return e({
			            reassign: function(e) {
			                t.entityManager.reassignEntity(e.entityId, e.parentEntityId);
			            },
			            create: function(e) {
			                t.entityManager.createEntity(e.entityConfig);
			            },
			            remove: function(e) {
			                t.entityManager.removeEntity(e.entityId);
			            }
			        });
			    };
			}), define("ZHY+SwV0SqzACJlEpd4XnqkDmP62fi13m3DTq4evdB8=", [ "1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=" ], function(e) {
			    "use strict";
			    return function(t) {
			        return e({
			            add: function(e) {
			                t.entityManager.addComponent(e.entityId, e.componentId);
			            },
			            remove: function(e) {
			                t.entityManager.removeComponent(e.entityId, e.componentId);
			            },
			            update: function(e) {
			                var n = t.entityManager.updateComponent(e.entityId, e.componentId, e.config);
			                n || t.logger.error("Could not update component '" + e.componentId + "' in entity " + e.entityId + ".");
			            }
			        });
			    };
			}), define("sue5lkVBqzKvL6Fk30ca23hDErzVxAbUl2Dno2KmJ/s=", [ "PF35L31cTrPY3rM0h3RsHDbSwWkzDUR3A+sTdxOq1so=" ], function(e) {
			    return e;
			}), define("wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=", [ "sue5lkVBqzKvL6Fk30ca23hDErzVxAbUl2Dno2KmJ/s=" ], function(e) {
			    var t = {};
			    return t.isArray = e.isArray, t.isObject = e.isObject, t.size = e.size, t.toArray = e.toArray, t.each = e.each, t.map = e.map, t.last = e.last, t.filter = e.filter, t.has = e.has, t.any = e.any, t.find = e.find, t.times = e.times, t.extend = e.extend, t.all = e.all, t.range = e.range, t.reduce = e.reduce, t.bind = e.bind, t.reject = e.reject, t.clone = e.clone, t.defaults = e.defaults, t.indexOf = e.indexOf, t.isString = e.isString, t.isEmpty = e.isEmpty, t.keys = e.keys, t.isFunction = e.isFunction, t.contains = e.contains, t.invoke = e.invoke, t.flatten = e.flatten, t.pick = e.pick, t.union = e.union, t.difference = e.difference, t.values = e.values, t.unique = e.unique, t.initial = e.initial, t.pluck = e.pluck, t.zip = e.zip, t.after = e.after, t.intersection = e.intersection, t.isNaN = e.isNaN, t.identity = e.identity, t;
			}), define("1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=", [ "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e) {
			    "use strict";
			    var t = function(e, t) {
			        t.charAt(0) === "." && (t = t.substring(1));
			        for (var n in e) if (t.lastIndexOf(n, 0) === 0) return n;
			    }, n = function(e, t) {
			        return e.substring(t.length + 1);
			    };
			    return function(e) {
			        return function(r, i, s) {
			            s || (s = "");
			            var o = t(e, i), u = e[o];
			            if (!u) throw "Error: No handler for message with id '" + s + (s !== "" ? "." : "") + i + "' found.";
			            var a = n(i, o);
			            u(r, a, s + o);
			        };
			    };
			}), define("0MEJAKZhgW4wQXJQv1R8sjWX6wvfv8nXtDUaZjRQxdw=", [ "1DRR6y6gIWNLBlHrm9gvioJqj6qz1R6BjAgtWBJ3+tU=", "ZHY+SwV0SqzACJlEpd4XnqkDmP62fi13m3DTq4evdB8=", "yK0eyZyMwZiwjPdm7fwzZv0BMUD7E0HxS/8Ny9G525k=", "CIb1nJXpKt9CP41s6SRsDATeI6HHJLUDIDiadaxfLaQ=", "Zt4dDF5B0lgdwIfuUagRZUHqy70yWlr5e3mCP8+h4ik=", "1rqqQwDriBtxhdpQLfU1QbOSpXNz0qE31+5K46MrYeE=", "ChYbCQykZBon8Ii54rxrAyc7zW54QvlnvqLfW3nPjN0=" ], function(e, t, n, r, i, s, o) {
			    "use strict";
			    return function(u, a) {
			        return e({
			            "spell.debug.component": t(u),
			            "spell.debug.entity": n(u),
			            "spell.debug.library": r(u),
			            "spell.debug.application": i(u, a),
			            "spell.debug.settings": s(u),
			            "spell.debug.system": o(u)
			        });
			    };
			}), define("spell/client/main", [ "0MEJAKZhgW4wQXJQv1R8sjWX6wvfv8nXtDUaZjRQxdw=", "IB9jfUoKNrdRjZqEIu7wNHEnyBRP4i1RaGStmBOiBQQ=", "C20TozIGoGYLzcTFVqaYDwSi189PvKkTfxhBjT84cFc=", "/onvXG9VhyKIuG0Hn1bR4/mu3mvWKrL3S9G1yf5s9Bs=", "7PhHlzIXiau/l87zhE3bIdhsPohgmy+yJQROuFXc0Uw=", "PbOCcvOCWKv40wXBycm4YMYdhAZoomihBhjVpxWEQTk=", "OINaBjfKqIjxReAWCGJlr0Uba7I0iYH8VHNPNtHxuOA=", "Qpj+fizmi2T5BUE0zCUFDzTWLiVETxC7mbwnh7FRpaU=", "GSV7+xwIB59dg5QN6WD1h1rWzVc9OwabH1SWt8Pk1c4=", "6LWBMS9D/d2r0J5+eQvSlL9x6G8sa+U+ODk4ht82dGw=", "5DXS8p6p/6XPSVo/sZHjU842Rl9MoWWPVu5I+ZXlneQ=", "hil8xb1IimJN9xLR8nPd5HFdl6J0s1wfcAnkDTTWJEw=", "aa1pimqD6igbBAjIMosAzz91SOAoYOjfpQNmoIqX0iE=", "QGfnGX0u4msE+kZC/56cY/9TOvn7ZCzFFI10N1Erczg=", "x81J/Fr9o8YgVYUYkA4GBLPAGmW4ok/0zW45f+sTXe4=", "Y+HrMll7Ng4+i8ynbZkdI2CDky7Ts7kFhGQCNWGqGQw=", "6E1ZytdZjwLqo2bG9x406AH0yHwVEopZ8vwpGvxsZyM=", "31xs7IP9/9HMl0FlArPRi/p/6e1y56BYxsmywdBgw2Y=", "vV8JUbcAFKwRw0kj9C+z03trX9WutPyp4SJONZGPilU=", "wVFr9CZXGUAbM65CNh4+09WyEbulEsZUP6h4oyE02mk=" ], function(e, t, n, r, i, s, o, u, a, f, l, c, h, p, d, v, m, g, y, b, w) {
			    "use strict";
			    var E = function(e, t) {
			        var i = this.spell, a = i.configurationManager, f = i.libraryManager;
			        n(i, a, e, e.config, i.loaderConfig), i.logger.setSendMessageToEditor(this.sendMessageToEditor), t && f.addToCache(t);
			        var c = m.RenderingFactory.createContext2d(i.eventManager, a.getValue("id"), a.getValue("currentScreenSize")[0], a.getValue("currentScreenSize")[1], a.getValue("renderingBackEnd"));
			        m.registerOnScreenResize(i.eventManager, a.getValue("id"), a.getValue("screenSize")), i.logger.debug("created rendering context (" + c.getConfiguration().type + ")");
			        var p = m.AudioFactory.createAudioContext(a.getValue("audioBackEnd"));
			        i.logger.debug("created audio context (" + p.getConfiguration().type + ")"), i.libraryManager.init(p, c);
			        var d = new u(f), g = a.getValue("mode") !== "deployed", w = h(f, g, a.getValue("libraryUrl")), E = new s(i, a, d, i.eventManager, f, w);
			        E.init();
			        var S = new o(i, E, i.statisticsManager, f, i.mainLoop, this.sendMessageToEditor, g), x = b.bind(y, null, f, a.getValue("currentLanguage")), T = new l(a, c);
			        T.init(), i.audioContext = p, i.assetManager = d, i.configurationManager = a, i.moduleLoader = w, i.entityManager = E, i.box2dContext = v(), i.box2dWorlds = {}, i.renderingContext = c, i.sceneManager = S, i.sendMessageToEditor = this.sendMessageToEditor, i.translate = x, i.inputManager = T, i.logger.debug("client started");
			        var N = function() {
			            i.sceneManager.startScene(i.applicationModule.startScene, {}, !g), i.mainLoop.run();
			        };
			        e.environment && e.environment.forceSplashScreen ? r(i, N) : N();
			    }, S = function(t) {
			        var n = {}, r = new d, s = new f, o = new a(s), u = new p, l = i(s, u);
			        o.setConfig(t), u.init(), n.applicationModule = undefined, n.configurationManager = o, n.eventManager = s, n.libraryManager = new c(s, o.getValue("libraryUrl")), n.loaderConfig = t, n.logger = r, n.mainLoop = l, n.registerTimer = m.registerTimer, n.scenes = {}, n.statisticsManager = u, n.storage = m.createPersistentStorage(), this.spell = n, t.mode !== "deployed" && (r.setLogLevel(r.LOG_LEVEL_DEBUG), g(r), this.debugMessageHandler = e(n, b.bind(this.start, this)));
			    }, x = function() {
			        this.spell, this.debugMessageHandler, this.sendMessageToEditor, S.call(this, w);
			    };
			    return x.prototype = {
			        start: E,
			        setSendMessageToEditor: function(e) {
			            this.sendMessageToEditor = e;
			        },
			        sendDebugMessage: function(e) {
			            this.debugMessageHandler(e.payload, e.type);
			        }
			    }, new x;
			});

		}
	}
}

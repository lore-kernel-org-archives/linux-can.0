From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [mkl-can-next:j1939 89/121] net/can/j1939/transport.c:1309
 j1939_session_fresh_new() error: use kfree_skb() here instead of kfree(skb)
Date: Sat, 16 Dec 2017 15:08:27 +0300
Message-ID: <20171216120827.ztws3ez5maqox7hx@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Kurt Van Dijck <kurt.van.dijck@eia.be>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git j1939
head:   31a3a5b6afa815d144da2d01940e493fb7b625f2
commit: dbdee3fe09a691eb4ddfedd349be5ffe5e866fb9 [89/121] j1939: transport: use common prefix j1939_session{,list}_ for all session{,list} related functions

smatch warnings:
show-warning-context "warning-lines" files

# https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=dbdee3fe09a691eb4ddfedd349be5ffe5e866fb9
git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
git remote update mkl-can-next
git checkout dbdee3fe09a691eb4ddfedd349be5ffe5e866fb9
vim +1309 net/can/j1939/transport.c

b99eb71b Kurt Van Dijck    2011-05-23  1285  
dbdee3fe Marc Kleine-Budde 2017-08-16  1286  static struct session *j1939_session_fresh_new(int size,
827881d3 Marc Kleine-Budde 2016-09-08  1287  					      struct sk_buff *rel_skb,
827881d3 Marc Kleine-Budde 2016-09-08  1288  					      pgn_t pgn)
b99eb71b Kurt Van Dijck    2011-05-23  1289  {
b99eb71b Kurt Van Dijck    2011-05-23  1290  	struct sk_buff *skb;
b99eb71b Kurt Van Dijck    2011-05-23  1291  	struct j1939_sk_buff_cb *cb;
b99eb71b Kurt Van Dijck    2011-05-23  1292  	struct session *session;
b99eb71b Kurt Van Dijck    2011-05-23  1293  
b99eb71b Kurt Van Dijck    2011-05-23  1294  	/* this SKB is allocated without headroom for CAN skb's.
b99eb71b Kurt Van Dijck    2011-05-23  1295  	 * This may not pose a problem, this SKB will never
b99eb71b Kurt Van Dijck    2011-05-23  1296  	 * enter generic CAN functions
b99eb71b Kurt Van Dijck    2011-05-23  1297  	 */
b99eb71b Kurt Van Dijck    2011-05-23  1298  	skb = alloc_skb(size, GFP_ATOMIC);
b99eb71b Kurt Van Dijck    2011-05-23  1299  	if (!skb)
b99eb71b Kurt Van Dijck    2011-05-23  1300  		return NULL;
b99eb71b Kurt Van Dijck    2011-05-23  1301  
15c8a9f1 Marc Kleine-Budde 2017-06-01  1302  	cb = j1939_get_cb(skb);
b99eb71b Kurt Van Dijck    2011-05-23  1303  	memcpy(cb, rel_skb->cb, sizeof(*cb));
b99eb71b Kurt Van Dijck    2011-05-23  1304  	fix_cb(cb);
669cff46 Marc Kleine-Budde 2017-08-16  1305  	cb->addr.pgn = pgn;
b99eb71b Kurt Van Dijck    2011-05-23  1306  
dbdee3fe Marc Kleine-Budde 2017-08-16  1307  	session = j1939_session_new(skb);
b99eb71b Kurt Van Dijck    2011-05-23  1308  	if (!session) {
b99eb71b Kurt Van Dijck    2011-05-23 @1309  		kfree(skb);
b99eb71b Kurt Van Dijck    2011-05-23  1310  		return NULL;
b99eb71b Kurt Van Dijck    2011-05-23  1311  	}
b99eb71b Kurt Van Dijck    2011-05-23  1312  	session->skb_iif = rel_skb->skb_iif;
b99eb71b Kurt Van Dijck    2011-05-23  1313  	skb->dev = rel_skb->dev;
70bbb5ad Marc Kleine-Budde 2016-09-08  1314  
b99eb71b Kurt Van Dijck    2011-05-23  1315  	/* alloc data area */
b99eb71b Kurt Van Dijck    2011-05-23  1316  	skb_put(skb, size);
b99eb71b Kurt Van Dijck    2011-05-23  1317  	return session;
b99eb71b Kurt Van Dijck    2011-05-23  1318  }
70bbb5ad Marc Kleine-Budde 2016-09-08  1319  

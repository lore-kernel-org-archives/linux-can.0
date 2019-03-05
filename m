From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [mkl-can-next:testing 9/14] drivers/net/can/flexcan.c:1262
 flexcan_open() warn: should '1 << (priv->tx_mb_idx)' be a 64 bit type?
Date: Tue, 5 Mar 2019 15:39:10 +0300
Message-ID: <20190305123909.GH13452@kadam>
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
To: kbuild@01.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
head:   3871ad024254a4ee2b330b52b15a5f3fb5ae077b
commit: c0ba9ac65ff1850978b6181318366814bcc5f1c8 [9/14] can: flexcan: introduce struct flexcan_priv::tx_mask and make use of it

smatch warnings:
drivers/net/can/flexcan.c:1262 flexcan_open() warn: should '1 << (priv->tx_mb_idx)' be a 64 bit type?

# https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=c0ba9ac65ff1850978b6181318366814bcc5f1c8
git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
git remote update mkl-can-next
git checkout c0ba9ac65ff1850978b6181318366814bcc5f1c8
vim +1262 drivers/net/can/flexcan.c

0517961cc Pankaj Bansal     2018-11-23  1250  	priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
6cbf76028 Pankaj Bansal     2018-08-28  1251  	priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
6cbf76028 Pankaj Bansal     2018-08-28  1252  			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
0517961cc Pankaj Bansal     2018-11-23  1253  
5156c7b11 Pankaj Bansal     2018-08-13  1254  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
0517961cc Pankaj Bansal     2018-11-23  1255  		priv->tx_mb_reserved =
0517961cc Pankaj Bansal     2018-11-23  1256  			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP);
5156c7b11 Pankaj Bansal     2018-08-13  1257  	else
0517961cc Pankaj Bansal     2018-11-23  1258  		priv->tx_mb_reserved =
0517961cc Pankaj Bansal     2018-11-23  1259  			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_FIFO);
0517961cc Pankaj Bansal     2018-11-23  1260  	priv->tx_mb_idx = priv->mb_count - 1;
0517961cc Pankaj Bansal     2018-11-23  1261  	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
c0ba9ac65 Marc Kleine-Budde 2019-03-01 @1262  	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
                                                ^^^^^^^^^^^^^
Presumably ->tx_mask is a u64?  Could it be made an unsigned long
instead?

5156c7b11 Pankaj Bansal     2018-08-13  1263  
5156c7b11 Pankaj Bansal     2018-08-13  1264  	priv->offload.mailbox_read = flexcan_mailbox_read;
5156c7b11 Pankaj Bansal     2018-08-13  1265  

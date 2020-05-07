From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] can: peak_canfd: Replace zero-length array with
 flexible-array
Date: Thu, 7 May 2020 13:51:09 -0500
Message-ID: <20200507185109.GA14002@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index d08a3d559114..6ad83a881039 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -146,7 +146,7 @@ struct pciefd_rx_dma {
 	__le32 irq_status;
 	__le32 sys_time_low;
 	__le32 sys_time_high;
-	struct pucan_rx_msg msg[0];
+	struct pucan_rx_msg msg[];
 } __packed __aligned(4);
 
 /* Tx Link record */
@@ -194,7 +194,7 @@ struct pciefd_board {
 	struct pci_dev *pci_dev;
 	int can_count;
 	spinlock_t cmd_lock;		/* 64-bits cmds must be atomic */
-	struct pciefd_can *can[0];	/* array of network devices */
+	struct pciefd_can *can[];	/* array of network devices */
 };
 
 /* supported device ids. */

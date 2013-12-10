From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/6] sllin: Make local functions static
Date: Tue, 10 Dec 2013 18:16:13 +0100
Message-ID: <1386695777-18463-3-git-send-email-alexander.stein@systec-electronic.com>
References: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60305 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755016Ab3LJR2U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 12:28:20 -0500
In-Reply-To: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index c1cdcd1..cf3cd75 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -609,7 +609,7 @@ static void sllin_receive_buf(struct tty_struct *tty,
  * @sl:
  * @err: Error flag to be sent.
  */
-void sllin_report_error(struct sllin *sl, int err)
+static void sllin_report_error(struct sllin *sl, int err)
 {
 	switch (err) {
 	case LIN_ERR_CHECKSUM:
@@ -694,7 +694,7 @@ static inline unsigned sllin_checksum(unsigned char *data, int length, int enhan
 #define SLLIN_STPMSG_CHCKSUM_CLS	(1 << 1)
 #define SLLIN_STPMSG_CHCKSUM_ENH	(1 << 2)
 
-int sllin_setup_msg(struct sllin *sl, int mode, int id,
+static int sllin_setup_msg(struct sllin *sl, int mode, int id,
 		unsigned char *data, int len)
 {
 	if (id > LIN_ID_MASK)
@@ -736,7 +736,7 @@ static void sllin_reset_buffs(struct sllin *sl)
 	sl->data_to_send = false;
 }
 
-int sllin_send_tx_buff(struct sllin *sl)
+static int sllin_send_tx_buff(struct sllin *sl)
 {
 	struct tty_struct *tty = sl->tty;
 	int remains;
@@ -795,7 +795,7 @@ error_in_write:
 }
 
 #ifdef BREAK_BY_BAUD
-int sllin_send_break(struct sllin *sl)
+static int sllin_send_break(struct sllin *sl)
 {
 	struct tty_struct *tty = sl->tty;
 	unsigned long break_baud;
@@ -820,7 +820,7 @@ int sllin_send_break(struct sllin *sl)
 }
 #else /* BREAK_BY_BAUD */
 
-int sllin_send_break(struct sllin *sl)
+static int sllin_send_break(struct sllin *sl)
 {
 	struct tty_struct *tty = sl->tty;
 	int retval;
@@ -916,7 +916,7 @@ static int sllin_rx_validate(struct sllin *sl)
  *  sllin_kwthread - kernel worker thread
  *****************************************/
 
-int sllin_kwthread(void *ptr)
+static int sllin_kwthread(void *ptr)
 {
 	struct sllin *sl = (struct sllin *)ptr;
 	struct tty_struct *tty = sl->tty;
-- 
1.8.3.2


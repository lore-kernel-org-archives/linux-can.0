From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.16 245/245] slcan: Don't transmit uninitialized stack
 data in padding
Date: Fri, 24 Apr 2020 00:07:52 +0100
Message-ID: <lsq.1587683028.722482633@decadent.org.uk>
References: <lsq.1587683027.831233700@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>, linux-can@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, davem@davemloft.net, netdev@vger.kernel.org, wg@grandegger.com, Richard Palethorpe <rpalethorpe@suse.com>, mkl@pengutronix.de
List-Id: linux-can.vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Palethorpe <rpalethorpe@suse.com>

commit b9258a2cece4ec1f020715fe3554bc2e360f6264 upstream.

struct can_frame contains some padding which is not explicitly zeroed in
slc_bump. This uninitialized data will then be transmitted if the stack
initialization hardening feature is not enabled (CONFIG_INIT_STACK_ALL).

This commit just zeroes the whole struct including the padding.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Fixes: a1044e36e457 ("can: add slcan driver for serial/USB-serial CAN adapters")
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: security@kernel.org
Cc: wg@grandegger.com
Cc: mkl@pengutronix.de
Cc: davem@davemloft.net
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/slcan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -150,7 +150,7 @@ static void slc_bump(struct slcan *sl)
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
-	cf.can_id = 0;
+	memset(&cf, 0, sizeof(cf));
 
 	switch (*cmd) {
 	case 'r':
@@ -189,8 +189,6 @@ static void slc_bump(struct slcan *sl)
 	else
 		return;
 
-	*(u64 *) (&cf.data) = 0; /* clear payload */
-
 	/* RTR frames may have a dlc > 0 but they never have any data bytes */
 	if (!(cf.can_id & CAN_RTR_FLAG)) {
 		for (i = 0; i < cf.can_dlc; i++) {

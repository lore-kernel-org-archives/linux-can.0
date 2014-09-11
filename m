From: Andri Yngvason <andri.yngvason@marel.com>
Subject: RFC: Improve and consolidate error state change
Date: Thu, 11 Sep 2014 19:09:20 +0000
Message-ID: <5411F360.4020103@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0075.outbound.protection.outlook.com ([207.46.100.75]:49945
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753442AbaIKTJ1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 11 Sep 2014 15:09:27 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello,

As we've discussed in a recent thread, error state changes are inconsistent
between platforms. Wolfgang had already done some work on this a couple of
years ago, but it never made it into the kernel.
See: http://thread.gmane.org/gmane.linux.can/201

I'm not going to address bus-off handling because it's a separate issue.

I've made 3 changes to Wolfgang's "common 'can_change_state()' function":
  * Instead on relying on txerr and rxerr to be in cf->data[6..7], to 
see if it's
    a tx/rx error, it's up to the user to pass information to the function.
    Rationale: Eliminate side-effects. This sort of behaviour is 
unexpected, when
    writing/reading code using this interface.
  * There is no CAN_ERR_STATE_CHANGE. Rationale: Although it adds 
clarity, it
    does not add any information; the user (in userspace) can track the
    direction of the change without having this flag.
  * Errors are only counted when the state escalates. Rationale: It 
feels like
    you're counting the error twice if it's also counted when the state is
    relaxed. I.e. warning->passive is counted but not passive->warning.

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 02492d2..abaf4db 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -273,6 +273,84 @@ static int can_get_bittiming(struct net_device 
*dev, struct can_bittiming *bt,
      return err;
  }

+enum can_err_dir can_get_err_dir(unsigned int txerr, unsigned int rxerr)
+{
+    if (txerr > rxerr)
+        return CAN_ERR_DIR_TX;
+    else if (rxerr < rxerr)
+        return CAN_ERR_DIR_RX;
+    else
+        return CAN_ERR_DIR_UNKNOWN;
+}
+EXPORT_SYMBOL_GPL(can_get_err_dir);
+
+static int can_make_state_warning(enum can_err_dir err_dir)
+{
+    switch (err_dir) {
+    case CAN_ERR_DIR_TX:
+        return CAN_ERR_CRTL_TX_WARNING;
+    case CAN_ERR_DIR_RX:
+        return CAN_ERR_CRTL_RX_WARNING;
+    default:
+        return CAN_ERR_CRTL_TX_WARNING | CAN_ERR_CRTL_RX_WARNING;
+    }
+}
+
+static int can_make_state_passive(enum can_err_dir err_dir)
+{
+    switch (err_dir) {
+    case CAN_ERR_DIR_TX:
+        return CAN_ERR_CRTL_TX_PASSIVE;
+    case CAN_ERR_DIR_RX:
+        return CAN_ERR_CRTL_RX_PASSIVE;
+    default:
+        return CAN_ERR_CRTL_TX_PASSIVE | CAN_ERR_CRTL_RX_PASSIVE;
+    }
+}
+
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+        enum can_state state, enum can_err_dir err_dir)
+{
+    struct can_priv *priv = netdev_priv(dev);
+
+    if (state == priv->state) {
+        netdev_warn(dev, "%s: oops, state did not change", __func__);
+        return;
+    }
+
+    if (state != CAN_STATE_BUS_OFF)
+        cf->can_id |= CAN_ERR_CRTL;
+
+    switch (state) {
+    case CAN_STATE_ERROR_WARNING:
+        if(state > priv->state)
+            priv->can_stats.error_warning++;
+        cf->data[1] = can_make_state_warning(err_dir);
+        break;
+
+    case CAN_STATE_ERROR_PASSIVE:
+        if(state > priv->state)
+            priv->can_stats.error_passive++;
+        cf->data[1] = can_make_state_passive(err_dir);
+        break;
+
+    case CAN_STATE_ERROR_ACTIVE:
+        cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+        break;
+
+    case CAN_STATE_BUS_OFF:
+        priv->can_stats.bus_off++;
+        cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+        break;
+
+    default:
+        break;
+    };
+
+    priv->state = state;
+}
+EXPORT_SYMBOL_GPL(can_change_state);
+
  /*
   * Local echo of CAN messages
   *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6992afc..0a5622f 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -27,6 +27,12 @@ enum can_mode {
      CAN_MODE_SLEEP
  };

+enum can_err_dir {
+    CAN_ERR_DIR_UNKNOWN = 0,
+    CAN_ERR_DIR_RX,
+    CAN_ERR_DIR_TX
+};
+
  /*
   * CAN common private data
   */
@@ -121,6 +127,10 @@ void unregister_candev(struct net_device *dev);
  int can_restart_now(struct net_device *dev);
  void can_bus_off(struct net_device *dev);

+enum can_err_dir can_get_err_dir(unsigned int txerr, unsigned int rxerr);
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+        enum can_state state, enum can_err_dir err_dir);
+
  void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
                unsigned int idx);
  unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index c247446..1c508be 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -71,6 +71,7 @@
  #define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status 
TX */
                        /* (at least one error counter exceeds */
                        /* the protocol-defined level of 127)  */
+#define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active state */

  /* error in CAN protocol (type) / data[2] */
  #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */

---

I've also edited the mscan, flexcan and sja1000 drivers to use this 
function,
but I actually don't have hardware to test this on any other platforms.

Is anyone willing to test this on other platforms?

I'll post patches, when there's been feedback on this.

Thanks,
Andri Yngvason


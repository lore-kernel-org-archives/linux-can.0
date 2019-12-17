From: Marek Vasut <marex@denx.de>
Subject: [PATCH] can: m_can: Fix default pinmux glitch at init
Date: Tue, 17 Dec 2019 11:07:40 +0100
Message-ID: <20191217100740.2687835-1-marex@denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Bich Hemon <bich.hemon@st.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "J . D . Schroeder" <jay.schroeder@garmin.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Roger Quadros <rogerq@ti.com>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

The current code causes a slight glitch on the pinctrl settings when used.
Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
the device core will automatically set the default pins. This causes the pins
to be momentarily set to the default and then to the sleep state in
register_m_can_dev(). By adding an optional "enable" state, boards can set the
default pin state to be disabled and avoid the glitch when the switch from
default to sleep first occurs. If the "enable" state is not available
pinctrl_get_select() falls back to using the "default" pinctrl state.

Fixes: c9b3bce18da4 ("can: m_can: select pinctrl state in each suspend/resume function")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bich Hemon <bich.hemon@st.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: J.D. Schroeder <jay.schroeder@garmin.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Roger Quadros <rogerq@ti.com>
Cc: linux-stable <stable@vger.kernel.org>
To: linux-can@vger.kernel.org
---
NOTE: This is commit 033365191136 ("can: c_can: Fix default pinmux glitch at init")
      adapted for m_can driver.
---
 drivers/net/can/m_can/m_can.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b73936..afb6760b17427 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1243,12 +1243,20 @@ static void m_can_chip_config(struct net_device *dev)
 static void m_can_start(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct pinctrl *p;
 
 	/* basic m_can configuration */
 	m_can_chip_config(dev);
 
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	/* Attempt to use "active" if available else use "default" */
+	p = pinctrl_get_select(cdev->dev, "active");
+	if (!IS_ERR(p))
+		pinctrl_put(p);
+	else
+		pinctrl_pm_select_default_state(cdev->dev);
+
 	m_can_enable_all_interrupts(cdev);
 }
 
-- 
2.24.0.525.g8f36a354ae

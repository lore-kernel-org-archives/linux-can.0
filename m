From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: [PATCH v4 0/1] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Tue,  3 Apr 2018 16:35:13 +0200
Message-ID: <20180403143514.24200-1-jakob.unterwurzacher@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jakob.unterwurzacher@theobroma-systems.com
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is v4 of the Theobroma Systems CAN/USB "UCAN" adapter driver
upstreaming effort.

v3 -> v4 changes:
* get rid of a few repeated le16_to_cpu casts by storing the value once
* fix canid masking logic
* drop __func__ from log messages. Use netdev_* where possible,
  use UCAN_DRIVER_NAME where not.
* drop device report log output (data is available via ip)
* fix issues catched by sparse

v2 -> v3 changes:
* count error frames as data packets
* use canid_t for all can ids
* use BIT(x) instead of (1 << x)
* use __le16 / __le32 for little-endian fields
* add spinlock around context allocation (fixes a possible race)
* fix comment style
* use WARN_ON return value
* fix state logic bug that did not allow return to ERROR_ACTIVE
* drop echo_index from context_array (not needed)
* rename "tx_contexts" -> "context_array" to prevent confusion
* add __func__ to all errors and warnings, and to info where it made sense

Jakob Unterwurzacher (1):
  can: ucan: add driver for Theobroma Systems UCAN devices

 Documentation/networking/can_ucan_protocol.rst |  315 +++++
 Documentation/networking/index.rst             |    1 +
 drivers/net/can/usb/Kconfig                    |   10 +
 drivers/net/can/usb/Makefile                   |    1 +
 drivers/net/can/usb/ucan.c                     | 1596 ++++++++++++++++++++++++
 5 files changed, 1923 insertions(+)
 create mode 100644 Documentation/networking/can_ucan_protocol.rst
 create mode 100644 drivers/net/can/usb/ucan.c

-- 
2.11.0

Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] can: fix USB altsetting bugs
Date: Tue, 10 Dec 2019 12:32:29 +0100
Message-ID: <20191210113231.3797-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-can.vger.kernel.org

We had quite a few driver using the first alternate setting instead of
the current one when doing descriptor sanity checks. This is mostly an
issue on kernels with panic_on_warn set due to a WARN() in
usb_submit_urn(). Since we've started backporting such fixes (e.g. as
reported by syzbot), I've marked these for stable as well.

The second patch here is a related cleanup to prevent future issues.

Johan


Johan Hovold (2):
  can: kvaser_usb: fix interface sanity check
  can: gs_usb: use descriptors of current altsetting

 drivers/net/can/usb/gs_usb.c                      | 4 ++--
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.24.0

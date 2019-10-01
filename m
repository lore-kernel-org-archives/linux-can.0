From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] can: fix use-after-free on USB disconnect
Date: Tue,  1 Oct 2019 12:29:12 +0200
Message-ID: <20191001102914.4567-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-can.vger.kernel.org

Syzbot reported a use-after-free on disconnect in mcba_usb and a quick
grep revealed a similar issue in usb_8dev.

Compile-tested only.

Johan


Johan Hovold (2):
  can: mcba_usb: fix use-after-free on disconnect
  can: usb_8dev: fix use-after-free on disconnect

 drivers/net/can/usb/mcba_usb.c | 3 +--
 drivers/net/can/usb/usb_8dev.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.23.0

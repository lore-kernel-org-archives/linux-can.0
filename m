From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 0/2] R-Car D3 (r8a77995) CAN support
Date: Mon, 18 Dec 2017 16:51:35 +0100
Message-ID: <1513612297-10173-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com, chris.paterson2@renesas.com, ramesh.shanmugasundaram@bp.renesas.com, robh@kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-can.vger.kernel.org

Hi!

These two patches are the leftovers of the "CAN for D3" series; as far
as I can tell, everything else has been picked up.

This revision fixes a copy/paste error and adds Acks and Reviewed-Bys.

CU
Uli


Ulrich Hecht (2):
  can: rcar_can: document r8a77995 (R-Car D3) compatibility strings
  can: rcar_canfd: document r8a77995 (R-Car D3) compatibility strings

 Documentation/devicetree/bindings/net/can/rcar_can.txt   | 13 +++++++------
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.7.4

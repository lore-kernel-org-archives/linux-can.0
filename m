From: <tthayer@altera.com>
Subject: [PATCHv2] Add support for standard D_CAN module RAM Init Bit
Date: Fri, 18 Apr 2014 09:03:13 -0500
Message-ID: <1397829794-9714-1-git-send-email-tthayer@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, tglx@linutronix.de
Cc: socketcan@hartkopp.net, anilkumar@ti.com, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tthayer.linux@gmail.com
List-Id: linux-can.vger.kernel.org

The standard D_CAN module includes the RAM Init bit in one of the 
D_CAN registers. This patch will properly initialize the RAM Init
bit which is self-clearing when the RAM Init is complete.
This patch fixes a boot message reporting an invalid resource as
well as the message saying control memory is not used for raminit.

[PATCHv2] net: c_can: Add support for D_CAN RAM Init bit in D_CAN

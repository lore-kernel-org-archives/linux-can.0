From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2017-12-01
Date: Fri,  1 Dec 2017 15:17:30 +0100
Message-ID: <20171201141739.5816-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull for net consisting of nine patches.

The first three patches are by Jimmy Assarsson for the kvaser_usb driver
and add the missing free()s in some error path, a signed/unsigned
comparison and ratelimit the error messages in case of incomplete
messages. Oliver Stäbler's patch for the ti_hecc driver fix the napi
poll function's return value. The return values of the probe function of
the peak_canfd and peak_pci PCI drivers are fixed by Stephane Grosjean's
patch. Two patches by me for the flexcan driver update the
bugs/features/quirks overview table and fix the error state transition
for the VF610 SoC. The two patches by Martin Kelly for the mcba_usb
driver fix a typo and a device disconnect bug.

regards,
Marc

---

The following changes since commit 6fef90c6b3f6a2b52018e66c0886944ea0c03fcc:

  net: dsa: bcm_sf2: Set correct CHAIN_ID and slice number mask (2017-11-30 14:21:35 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.15-20171201

for you to fetch changes up to 1cb35a33a28394fd711bb26ddf3a564f4e9d9125:

  can: mcba_usb: fix device disconnect bug (2017-12-01 11:27:14 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.15-20171201

----------------------------------------------------------------
Jimmy Assarsson (3):
      can: kvaser_usb: free buf in error paths
      can: kvaser_usb: Fix comparison bug in kvaser_usb_read_bulk_callback()
      can: kvaser_usb: ratelimit errors if incomplete messages are received

Marc Kleine-Budde (2):
      can: flexcan: Update IRQ Err Passive information
      can: flexcan: fix VF610 state transition issue

Martin Kelly (2):
      can: mcba_usb: fix typo
      can: mcba_usb: fix device disconnect bug

Oliver Stäbler (1):
      can: ti_hecc: Fix napi poll return value for repoll

Stephane Grosjean (1):
      can: peak/pci: fix potential bug when probe() fails

 drivers/net/can/flexcan.c                     |  9 +++++----
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  5 ++++-
 drivers/net/can/sja1000/peak_pci.c            |  5 ++++-
 drivers/net/can/ti_hecc.c                     |  3 +++
 drivers/net/can/usb/kvaser_usb.c              | 11 +++++++----
 drivers/net/can/usb/mcba_usb.c                |  3 ++-
 6 files changed, 25 insertions(+), 11 deletions(-)

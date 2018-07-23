From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2018-07-23
Date: Mon, 23 Jul 2018 14:58:31 +0200
Message-ID: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of 12 patches for net/master.

The patch by Stephane Grosjean for the peak_canfd CAN driver fixes a problem
with older firmware. The next patch is by Roman Fietze and fixes the setup of
the CCCR register in the m_can driver. Nicholas Mc Guire's patch for the
mpc5xxx_can driver adds missing error checking. The two patches by Faiz Abbas
fix the runtime resume and clean up the probe function in the m_can driver. The
last 7 patches by Anssi Hannula fix several problem in the xilinx_can driver.

regards,
Marc

---

The following changes since commit c9ce1fa1c24b08e13c2a3b5b1f94a19c9eaa982c:

  net: prevent ISA drivers from building on PPC32 (2018-07-22 11:12:29 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.18-20180723

for you to fetch changes up to 8ebd83bdb027f29870d96649dba18b91581ea829:

  can: xilinx_can: fix power management handling (2018-07-23 14:34:46 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.18-20180723

----------------------------------------------------------------
Anssi Hannula (7):
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
      can: xilinx_can: fix RX overflow interrupt not being enabled
      can: xilinx_can: fix incorrect clear of non-processed interrupts
      can: xilinx_can: fix power management handling

Faiz Abbas (2):
      can: m_can: Fix runtime resume call
      can: m_can: Move accessing of message ram to after clocks are enabled

Nicholas Mc Guire (1):
      can: mpc5xxx_can: check of_iomap return before use

Roman Fietze (1):
      can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit before checking can.ctrlmode

Stephane Grosjean (1):
      can: peak_canfd: fix firmware < v3.3.0: limit allocation to 32-bit DMA addr only

 drivers/net/can/m_can/m_can.c                 |  18 +-
 drivers/net/can/mscan/mpc5xxx_can.c           |   5 +
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  19 ++
 drivers/net/can/xilinx_can.c                  | 392 +++++++++++++++++++-------
 4 files changed, 321 insertions(+), 113 deletions(-)

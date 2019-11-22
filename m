From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2019-11-22
Date: Fri, 22 Nov 2019 15:52:49 +0100
Message-ID: <20191122145251.9775-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of 2 patches for net/master, if possible for the
current release cycle. Otherwise these patches should hit v5.4 via the
stable tree.

Both patches of this pull request target the m_can driver. Pankaj Sharma
fixes the fallout in the m_can_platform part, which appeared with the
introduction of the m_can platform framework.

regards,
Marc

---

The following changes since commit d814b67e50dc53c3c83932d7020d1719af1e68dc:

  Merge branch 'hv_netvsc-Fix-send-indirection-table-offset' (2019-11-21 19:32:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.4-20191122

for you to fetch changes up to 0704c57436947c9f9f6472fd1a5ade41fc4c19d8:

  can: m_can_platform: remove unnecessary m_can_class_resume() call (2019-11-22 15:34:37 +0100)

----------------------------------------------------------------
linux-can-fixes-for-5.4-20191122

----------------------------------------------------------------
Pankaj Sharma (2):
      can: m_can_platform: set net_device structure as driver data
      can: m_can_platform: remove unnecessary m_can_class_resume() call

 drivers/net/can/m_can/m_can_platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

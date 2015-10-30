From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2015-10-30
Date: Fri, 30 Oct 2015 14:39:58 +0100
Message-ID: <1446212399-31546-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request for the upcoming v4.3 release.

Marek Vasut provides a patch to use the correct attrlen in the nla_put() in the
can_fill_info() function.

regards,
Marc

---

The following changes since commit 89bc7848a91bc99532f5c21b2885472ba710f249:

  ipv6: protect mtu calculation of wrap-around and infinite loop by rounding issues (2015-10-29 07:01:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.3-20151030

for you to fetch changes up to 562b103a21974c2f9cd67514d110f918bb3e1796:

  can: Use correct type in sizeof() in nla_put() (2015-10-30 14:33:26 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.3-20151030

----------------------------------------------------------------
Marek Vasut (1):
      can: Use correct type in sizeof() in nla_put()

 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

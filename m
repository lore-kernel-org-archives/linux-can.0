From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 0/5] j1939 fixes
Date: Fri,  7 Aug 2020 12:51:55 +0200
Message-ID: <20200807105200.26441-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, David Jander <david@protonic.nl>
List-Id: linux-can.vger.kernel.org

This patch set include different fixes reported by google syzkaller or
other users.

Oleksij Rempel (5):
  can: j1939: transport: j1939_simple_recv(): ignore local J1939
    messages send not by J1939 stack
  can: j1939: transport: j1939_session_tx_dat(): fix use-after-free read
    in j1939_tp_txtimer()
  can: j1939: socket: j1939_sk_bind(): make sure ml_priv is allocated
  can: j1939: transport: add j1939_session_skb_find_by_offset() function
  can: j1939: transport: j1939_xtp_rx_dat_one(): compare own packets to
    detect corruptions

 net/can/j1939/socket.c    |  9 +++++++
 net/can/j1939/transport.c | 56 +++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.28.0

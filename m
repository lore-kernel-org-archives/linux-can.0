From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 0/9] can: j1939: fix multiple issues found by syzbot
Date: Tue, 12 Nov 2019 12:15:51 +0100
Message-ID: <20191112111600.18719-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Most of this issues was found by test provided with following syzbot report:
https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

Other syzbot reports are probably different incarnation of the same or
combination of bugs:

https://syzkaller.appspot.com/bug?extid=07bb74aeafc88ba7d5b4
https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
https://syzkaller.appspot.com/bug?extid=6d04f6a1b31a0ae12ca9
https://syzkaller.appspot.com/bug?extid=7044ea77452b6f92b4fd
https://syzkaller.appspot.com/bug?extid=95c8e0d9dffde15b6c5c
https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
https://syzkaller.appspot.com/bug?extid=feff46f1778030d14234

Oleksij Rempel (9):
  can: af_can: export can_sock_destruct()
  can: j1939: move j1939_priv_put() into sk_destruct callback
  can: j1939: main: j1939_ndev_to_priv(): avoid crash if can_ml_priv is
    NULL
  can: j1939: socket: rework socket locking for j1939_sk_release() and
    j1939_sk_sendmsg()
  can: j1939: transport: make sure the aborted session will be
    deactivated only once
  can: j1939: make sure socket is held as long as session exists
  can: j1939: transport: j1939_cancel_active_session(): use
    hrtimer_try_to_cancel() instead of hrtimer_cancel()
  can: j1939: j1939_can_recv(): add priv refcounting
  can: j1939: warn if resources are still linked on destroy

 include/linux/can/core.h  |  1 +
 net/can/af_can.c          |  3 +-
 net/can/j1939/main.c      |  9 ++++
 net/can/j1939/socket.c    | 94 ++++++++++++++++++++++++++++++---------
 net/can/j1939/transport.c | 36 +++++++++++----
 5 files changed, 113 insertions(+), 30 deletions(-)

-- 
2.24.0.rc1

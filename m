From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2018-01-18
Date: Thu, 18 Jan 2018 11:15:05 +0100
Message-ID: <20180118101507.17943-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755495AbeARKPf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Jan 2018 05:15:35 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

this is a pull reqeust of two patches for net/master:

The syzkaller project triggered two WARN_ONCE() in the af_can code from
userspace and we decided to replace it by a pr_warn_once().

regards,
Marc

---

The following changes since commit ad9294dbc227cbc8e173b3b963e7dd9af5314f77:

  bpf: fix cls_bpf on filter replace (2018-01-17 17:14:06 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.15-20180118

for you to fetch changes up to d4689846881d160a4d12a514e991a740bcb5d65a:

  can: af_can: canfd_rcv(): replace WARN_ONCE by pr_warn_once (2018-01-18 09:32:54 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.15-20180118

----------------------------------------------------------------
Marc Kleine-Budde (2):
      can: af_can: can_rcv(): replace WARN_ONCE by pr_warn_once
      can: af_can: canfd_rcv(): replace WARN_ONCE by pr_warn_once

 net/can/af_can.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)


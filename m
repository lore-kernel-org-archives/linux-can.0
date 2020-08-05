From: Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: [PATCH net 0/4] support multipacket broadcast message
Date: Wed, 5 Aug 2020 11:50:21 +0800
Message-ID: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbgHEDuu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 4 Aug 2020 23:50:50 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Zhang Changzhong (4):
  can: j1939: fix support for multipacket broadcast message
  can: j1939: cancel rxtimer on multipacket broadcast session complete
  can: j1939: abort multipacket broadcast session when timeout occurs
  can: j1939: add rxtimer for multipacket broadcast session

 net/can/j1939/transport.c | 48 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

-- 
2.9.5

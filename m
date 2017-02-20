From: <Wenyou.Yang@microchip.com>
Subject: iproute2 not function on CAN FD
Date: Mon, 20 Feb 2017 01:12:52 +0000
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB4D7587@CHN-SV-EXMX07.mchp-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from exsmtp02.microchip.com ([198.175.253.38]:37831 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751534AbdBTBNg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 19 Feb 2017 20:13:36 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net, mkl@pengutronix.de, wg@grandegger.com
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

I am testing the CAN FD of M_CAN on the SAMA5D2 Xplained board, 
when using the ip tool from iprounte2 suite to set the CAN interface,
it doesn't work with the message "RTNETLINK answers: Operation not supported".
--->8----
# ip link set can0 type can bitrate 125000 dbitrate 8000000 fd on
RTNETLINK answers: Operation not supported
---8<---

The version of iproute2 suite: 4.5.0 (iproute2-4.5.0)
--->8----
# ip -V
ip utility, iproute2-ss160314
---8<----

The kernel version: 4.9.0

I have looked on google to try to find a solution, it seems that my kernel configuration is missing something, 
http://superuser.com/questions/232807/iproute2-not-functioning-rtnetlink-answers-operation-not-supported

According to the document, I enabled the below options based on arch/arm/configs/sama5_defconfig, it still doesn't work.

--->8----
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y

CONFIG_NETFILTER=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_CT_NETLINK=y
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_CLS_ACT=y

CONFIG_SCSI_FC_ATTRS=y
---8<----

Any help would be really appreciated.



Best Regards,
Wenyou Yang


Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADBCC433ED
	for <linux-can@archiver.kernel.org>; Thu,  6 May 2021 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A882A61164
	for <linux-can@archiver.kernel.org>; Thu,  6 May 2021 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhEFLP0 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 6 May 2021 07:15:26 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:54403 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbhEFLP0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 May 2021 07:15:26 -0400
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d58 with ME
        id 1PEF250013PnFJp03PEQrr; Thu, 06 May 2021 13:14:26 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 May 2021 13:14:26 +0200
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v1 0/1] add the netlink interface for CAN-FD Transmitter Delay Compensation (TDC)
Date:   Thu,  6 May 2021 20:14:11 +0900
Message-Id: <20210506111412.1665835-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This serie contains a single patch which adds a netlink interface for
the TDC parameters using netlink nested attributes.

In March, I introduced the Transmitter Delay Compensation (TDC) to the
kernel though two patches:
  - commit 289ea9e4ae59 ("can: add new CAN FD bittiming parameters:
    Transmitter Delay Compensation (TDC)")
  - commit c25cc7993243 ("can: bittiming: add calculation for CAN FD
    Transmitter Delay Compensation (TDC)")

The netlink interface was missing from this series because the initial
patch needed rework in order to make it more flexible for future
changes.

At that time, Marc suggested to take inspiration from the recently
released ethtool-netlink interface.
Ref: https://lore.kernel.org/linux-can/20210407081557.m3sotnepbgasarri@pengutronix.de/

After further research, it appears that ethtool uses nested attributes
(c.f. NLA_NESTED type in validation policy). A bit of trivia: the
NLA_NESTED type was introduced in version 2.6.15 of the kernel and
thus actually predates Socket CAN.
Ref: commit bfa83a9e03cf ("[NETLINK]: Type-safe netlink
messages/attributes interface")

It took me a bit of time to understand and figure out how to use those
nested attributes. While the patch should be functional, I am not fully
done with my testing yet. I thus send this version as an RFC. I wish
to receive comments of the overall design. Contents of the functions
might still be subjected to small changes.

After gathering the comments, I will send a new version in which I
will also include an update to Documentation/networking/can.rst.

Vincent Mailhol (1):
  can: netlink: add interface for CAN-FD Transmitter Delay Compensation
    (TDC)

 drivers/net/can/dev/Makefile      |   1 +
 drivers/net/can/dev/netlink-tdc.c | 122 ++++++++++++++++++++++++++++++
 drivers/net/can/dev/netlink-tdc.h |  18 +++++
 drivers/net/can/dev/netlink.c     |  15 +++-
 include/uapi/linux/can/netlink.h  |  28 ++++++-
 5 files changed, 179 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/can/dev/netlink-tdc.c
 create mode 100644 drivers/net/can/dev/netlink-tdc.h

-- 
2.26.3


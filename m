Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E7FC433DB
	for <linux-can@archiver.kernel.org>; Tue, 23 Feb 2021 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C00864E3F
	for <linux-can@archiver.kernel.org>; Tue, 23 Feb 2021 16:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBWQbV (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:31:21 -0500
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:56610 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBWQbV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 11:31:21 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d21 with ME
        id YgVU2400P3PnFJp03gVZU8; Tue, 23 Feb 2021 17:29:35 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Feb 2021 17:29:35 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 0/5] Introducing new CAN FD bittiming parameters: Transmission Delay Compensation (TDC)
Date:   Wed, 24 Feb 2021 01:28:47 +0900
Message-Id: <20210223162852.218041-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

At high bit rates, the propagation delay from the TX pin to the RX pin
of the transceiver causes measurement errors and needs to be
corrected.

To solve this issue, ISO 11898-1 introduces in section 11.3.3
"Transmitter delay compensation" (here after TDC) a SSP (Secondary
Sample Point) equal to the distance, in time quanta, from the start of
the bit time on the TX pin to the actual measurement on the RX pin.

This patch series implements the TDC parameters which allow the
controller to calculate that SSP.

The first patch introduces the new structures, the second one saves
eight bytes on struct can_priv, the third fix some existing checkpatch
warnings in preparation on the next one, the fourth one implement the
netlink interface and, finally, the fifth one add the calculation.

This is a follow-up on the RFC is sent already more than one month
ago.

Ref: https://lore.kernel.org/linux-can/CAMZ6RqLtg1ynVeePLLriUw0+KLbTpPJHapTEanv1_EZYJSrK=g@mail.gmail.com/T/#u

Changes from the RFC:
  - The RFC was a single e-mail with all comments in bulk, made this a
    proper patch series.
  - Added the netlink interface.
  - Rename the function can_set_tdc to can_calc_tdco (the formula is
    the same, everything around was reworked).
  - Other small miscellaneous changes.

TODO: the documentation will be updated after the netlink interface
gets approved.

Vincent Mailhol (5):
  can: add new CAN FD bittiming parameters: Transmitter Delay
    Compensation (TDC)
  can: dev: reorder struct can_priv members for better packing
  can: netlink: move '=' operators back to previous line (checkpatch
    fix)
  can: add netlink interface for CAN-FD Transmitter Delay Compensation
    (TDC)
  can: bittiming: add calculation for CAN FD Transmitter Delay
    Compensation (TDC)

 drivers/net/can/dev/bittiming.c  |  23 +++++++
 drivers/net/can/dev/netlink.c    | 100 ++++++++++++++++++++++++++-----
 include/linux/can/bittiming.h    |  71 ++++++++++++++++++++++
 include/linux/can/dev.h          |  14 +++--
 include/uapi/linux/can/netlink.h |   6 ++
 5 files changed, 194 insertions(+), 20 deletions(-)


base-commit: 1b34628ac60360ef7455c00f01dc62f82ed08d8c
-- 
2.26.2


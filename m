From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv handling
Date: Wed,  2 Aug 2017 19:44:20 +0200
Message-ID: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43143 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751991AbdHBRoi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:38 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hello,

while reviwing and cleaning up the j1939 stack I digged a bit deeper into
af_can and raw implementation.

The first patch adds a missing error check and will probably go into -stable.
Patches 2-8 change some struct and variable names, making the code more
readble, IMHO.
Patch 9 removed the need for struct raw_sock::ifindex from the raw sock, by
using struct sock::sk_bound_dev_if from the generic socket structure.
Patch 10: Checks if can_family is AF_CAN in raw's bind function.
Patch 11: Cleans up the newly integrated CAN net namespace support.

Patches 13-14: Where to put the per device protocol specific memory? af_can
allocated it's memory during a netdev_notifier call, life cycle proves to be
rather complicated (see remove_on_zero_entries, etc...), adding the j1939
memory makes it even more compilcated. So I decided to allocate the memory
during the allocation if net_device. And this seems to work. More details in
the individual patches.

This series applies to net-next/master, but should work on any recent kernel.
Please review, test and comment.

regards,
Marc


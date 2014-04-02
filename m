From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 0/3] can: add support for hash based access to EFF frame filters
Date: Wed,  2 Apr 2014 20:25:24 +0200
Message-ID: <1396463127-25541-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:64093 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbaDBSZh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 14:25:37 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

In contrast to the direct access to the single SFF frame filters (which are
indexed by the SFF CAN ID itself) the single EFF frame filters are arranged
in a single linked hlist. To reduce the hlist traversal in the case of many
filter subscriptions a hash based access is introduced for single EFF filters.

This patch set enhances and documents the hash based EFF filter sets in
af_can.c .

Changes in v2:
Some coding style fixes, like
- indroduce spaces arround shift operations
- use ARRAY_SIZE(d->rx_sff) instead of CAN_SFF_RCV_ARRAY_SZ
- use ARRAY_SIZE(d->rx_eff) instead of CAN_EFF_RCV_ARRAY_SZ
- change to forward hash function as suggested by Marc

Oliver Hartkopp (3):
  can: proc: make array printing function indenpendent from sff frames
  can: add hash based access to single EFF frame filters
  can: add documentation for CAN filter usage optimisation

 Documentation/networking/can.txt | 35 ++++++++++++++++++
 net/can/af_can.c                 | 31 +++++++++++++---
 net/can/af_can.h                 |  9 +++--
 net/can/proc.c                   | 76 ++++++++++++++++++++++++++++++++--------
 4 files changed, 129 insertions(+), 22 deletions(-)

-- 
1.9.1


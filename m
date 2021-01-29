Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF635C433E0
	for <linux-can@archiver.kernel.org>; Fri, 29 Jan 2021 17:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605D964D9A
	for <linux-can@archiver.kernel.org>; Fri, 29 Jan 2021 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhA2REe (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:04:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:49806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhA2REX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 29 Jan 2021 12:04:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611939816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=urqIhegsxh2vaWCOT9YaPeuULZIBdkaKaHNo1UPjvQs=;
        b=WJfp2PKVh1G21RA+TY65XX0kgNVJFSf+grhJTAmW1BN5lyruS90eWxe81hJklG/jQcIPl8
        nf998hS+OjjkZnjjDpojZLHoMbL+Sc9YGJ+r1tGaEfaYidRIMY9WDER6JZYhF/7fLuxqmk
        key6LKJeMC5dD5WVDP++YdrJ3pLGjVc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 860DEABD6;
        Fri, 29 Jan 2021 17:03:36 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v4 0/7] Convert CAN tests to new LTP API
Date:   Fri, 29 Jan 2021 17:02:58 +0000
Message-Id: <20210129170305.27383-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

This converts the CAN tests to the modern Linux Test Project API and
removes the wrapper script. To be clear, this is a patch-set for the
LTP *not* the kernel tree or can-utils.

I have tried to keep the core test behaviour the same, but (for
example) moving to the SAFE_ functions will naturally introduce some
changes in error checking. Deliberate behavioral changes have been
noted in the commit messages.

FYI, we appear to have 4 CAN tests in LTP including two tests for
SLCAN (pty03, pty04). It appears these could be quite easily extended.

V2: Update e-mail addresses and resend
V3:
* Add COPYING and use dual license SPDX identifier
* Fix compilation issues with can_common.h
V4:
* Remove IFF_ECHO fallback which is not needed with only linux/if.h
* Add missing static to function
* State effect of echo on coverage
* remove shell script from runtest file
* Add various git trailers

Richard Palethorpe (7):
  API: Add FILE_SCANF to new lib
  can: Add can_common.h for vcan device setup
  can: Add COPYING with dual license text
  can_filter: Convert to new library
  can_recv_own_msgs: Convert to new library
  can: Remove obsolete test wrapper script
  can: Update contact details

 include/tst_safe_file_ops.h                   |   3 +
 runtest/can                                   |   4 +-
 testcases/network/can/Makefile                |   2 -
 .../can/filter-tests/00_Descriptions.txt      |   6 +-
 testcases/network/can/filter-tests/COPYING    |  35 ++
 testcases/network/can/filter-tests/INSTALL    |   3 +-
 testcases/network/can/filter-tests/Makefile   |   4 -
 .../network/can/filter-tests/can_common.h     |  71 ++++
 .../network/can/filter-tests/can_filter.c     | 317 +++++++-----------
 .../can/filter-tests/can_rcv_own_msgs.c       | 273 +++++----------
 .../network/can/filter-tests/can_run_tests.sh | 106 ------
 11 files changed, 329 insertions(+), 495 deletions(-)
 create mode 100644 testcases/network/can/filter-tests/COPYING
 create mode 100644 testcases/network/can/filter-tests/can_common.h
 delete mode 100755 testcases/network/can/filter-tests/can_run_tests.sh

-- 
2.30.0


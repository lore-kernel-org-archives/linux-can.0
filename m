Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F27DC433F5
	for <linux-can@archiver.kernel.org>; Tue, 22 Feb 2022 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiBVPKH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiBVPKG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:10:06 -0500
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 07:09:40 PST
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8010EC4A
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:09:40 -0800 (PST)
Received: from skn-laptop.hadsten (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id BEBD81299B3;
        Tue, 22 Feb 2022 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1645542214; bh=xQt6ZKkhvDxzPNdVMBTcgetxiwOYUoOD5/+9OwjO8Ew=;
        h=Date:From:To:Subject;
        b=S22nPej+/33w0h62IBT3Wip6wamotorhKrtt25DTWK+Wa8eN5IOeKZOff0xiXFklf
         ZRm3vr5ovru/zvqtoqx4yTQ0j5cNAqCjudMUfanexu3sjZeav6ZZKKbuz/nWQIV4r3
         LMs80y6fV6T7PGThOs2e3uLXyiXjoG7QfwLRQs1R4ici66+Sp8HkcJBHMHoh0N9m6r
         ceALNd8zUEMVsa5WWxTgtER4bcrf6V7MksF3Um+j+rXqUw5iR+uGuu54MWkzJjtDYz
         J97Jq/ibwcsUM9Ipz3SG+UWA+mN5jQC0BtKaQcX6AWnbN10BWd88MhHwOi754Y0D5G
         LrQSkcAIBGlEg==
Date:   Tue, 22 Feb 2022 16:03:34 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de
Subject: can: m_can: tcan4x5x: wake pin
Message-ID: <20220222150334.rbhm3uzbh4jp4ap4@skn-laptop.hadsten>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

The TCAN4x5x device have 2 wake pins. One for waking the host controller
and one for waking the tcan controller it self.

We only have the wake for the tcan controller it self implemented right?

I have a task that would enable our host to wake-on-can traffic.

/Sean

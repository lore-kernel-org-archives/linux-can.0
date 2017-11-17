From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: PCAN-USB on 3v3 CAN
Date: Fri, 17 Nov 2017 14:29:54 +0100
Message-ID: <20171117132954.GA7355@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:60616 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756716AbdKQNtX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Nov 2017 08:49:23 -0500
Received: from zotac.vandijck-laurijssen.be (77.109.102.73.adsl.dyn.edpnet.net [77.109.102.73]) by relay-b01.edpnet.be with ESMTP id aUgw7svECLUnFCbv for <linux-can@vger.kernel.org>; Fri, 17 Nov 2017 14:29:56 +0100 (CET)
Received: from airbook.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 4DB05439974
        for <linux-can@vger.kernel.org>; Fri, 17 Nov 2017 14:29:56 +0100 (CET)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I have difficulty connecting my PCAN-USB to a CAN network
where all nodes have a 3v3 transceiver,
and the obscure bitrate of 923kBit.

Since this is the first time I encountered a '3v3' CAN bus,
I was a bit supprised. Will this work with my (I think) 5v PCAN-USB?
Is this transceiver voltage interchangeable?

Kind regards,
Kurt

From: "Grim, Dennis" <Dennis.Grim@teejet.com>
Subject: canfdtest and CPU load average
Date: Fri, 2 Dec 2016 20:10:24 +0000
Message-ID: <1579A5A5423CC14B827884B535F8E9513494220F@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ms.spray.com ([207.247.13.3]:58088 "EHLO mail.spray.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753520AbcLBUKZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 2 Dec 2016 15:10:25 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

The recent update of canfdtest (can-utils) significantly reduces the CPU load average that I see when testing.

It seems likely that using gettimeofday in a tight loop in can_echo_dut was the issue.

Dennis


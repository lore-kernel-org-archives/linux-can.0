From: "Grim, Dennis" <Dennis.Grim@teejet.com>
Subject: canfdtest and CPU load average
Date: Fri, 18 Nov 2016 22:22:55 +0000
Message-ID: <1579A5A5423CC14B827884B535F8E95134940DBD@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ms.spray.com ([207.247.13.3]:56001 "EHLO mail.spray.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751716AbcKRWW5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 18 Nov 2016 17:22:57 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

When running canfdtest on ARM Cortex-A8 (TI AM3517) based custom hardware, the CPU load average is high.

The hardware comprises the AM3517 HECC and two SJA1000s.

With the custom hardware running three instances of canfdtest (as device under test) at 250000 bits per second, the CPU load average is roughly 2.  No other applications are running.

Are there things in the Linux network stack that can be tuned that might lower the load?

Dennis




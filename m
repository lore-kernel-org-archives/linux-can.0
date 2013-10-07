From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: =?UTF-8?Q?GS=5FUSB?=
Date: Mon, 07 Oct 2013 16:37:32 +0200
Message-ID: <5e3f6029b128db63c69664deed10c5d6@grandegger.com>
References: <1380889887.22484.2.camel@blackbox>
 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:54666 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab3JGOhe (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 7 Oct 2013 10:37:34 -0400
In-Reply-To: <1381155720.21207.7.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

On Mon, 07 Oct 2013 14:22:00 +0000, "Max S." <max@schneidersoft.net>

wrote:

> Hello Wolfgang,

> 

> Here is the cleaned up patch incorporating your suggestions.

> 

> I am using "git commit --amend" to compile changes into a single patch.

> Is this the correct method?



I normally use "git rebase -i <first-commit-id>"? It's very

powerful and allows to reorder, squash, re-word commits and

much more.



Will not find time for the review today...



The CAN controller does not do any asynchronous error reporting,

right? This will limit the usability of this device, especially

CAN applications relying on that feature will not work. Any chance

to add asynchronous error reporting to the firmware?



Wolfgang.



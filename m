From: Armin Burchardt <armin@uni-bremen.de>
Subject: Re: CAN Bus Cable
Date: Tue, 14 Jul 2015 19:16:13 +0200
Message-ID: <55A543DD.80701@uni-bremen.de>
References: <20150713110817.GE25291@bamboo.electronicsoup> <FF0E019DD74E2349AE9109F955A784D00EFC8194@chn-hclt-mbs06.HCLT.CORP.HCL.IN> <20150713192802.GF25291@bamboo.electronicsoup>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:34530 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752285AbbGNRQP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jul 2015 13:16:15 -0400
In-Reply-To: <20150713192802.GF25291@bamboo.electronicsoup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>
Cc: linux-can@vger.kernel.org

Hi John,

On 13.07.2015 21:28, John Whitmore wrote:
> No it's the actual copper cable I'm looking for. I'm creating my own CAN Bus
> network.

what you need is a balanced cable with an impedance of 120 Ohm
(matching the terminating resistors on each end).
Usually, this is a twisted pair of wires.

Armin

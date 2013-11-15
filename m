From: "Max S." <max@schneidersoft.net>
Subject: Re: GS_USB
Date: Fri, 15 Nov 2013 10:39:59 +0000
Message-ID: <1384511999.3561.8.camel@blackbox>
References: <1380889887.22484.2.camel@blackbox>
	  <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>
	  <5e3f6029b128db63c69664deed10c5d6@grandegger.com>
	  <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com>
	  <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com>
	  <1384135835.3749.31.camel@blackbox>
	  <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>
	  <5280FAB2.3030600@hartkopp.net> <1384199350.3483.20.camel@blackbox>
	 <528150F3.8090406@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:58142 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab3KOK1D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Nov 2013 05:27:03 -0500
In-Reply-To: <528150F3.8090406@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>

Hello all,

I've been doing some more testing and came across some strange behavior.
Frames appear to be out of order.

I have both chanels of the GS_USB device and a PEAKUSB adapter on a bus,
as well as another node (to ack frames).

I have modified the GS_USB firmware to PANIC when txed frames are out of
sequence.

tx interrupt now looks something like this

static uint8_t count = 0;
void tx_channel_0_interrupt(void){
	PANIC(txframe.data[0] != count);
	count++;

The GS_SUB device never panics, however cansequence -r on the peak
device gives me messages like:

received wrong sequence count. expected: 216, got: 220
received wrong sequence count. expected: 224, got: 216
received wrong sequence count. expected: 220, got: 224
received wrong sequence count. expected: 227, got: 229
received wrong sequence count. expected: 233, got: 227
received wrong sequence count. expected: 229, got: 233

notice that no frames are lost, just rearranged.

I can force frames to be out of order by restarting cansequence, so i
know my monitor code is working.

I have been trying to reproduce this error using libusb in userspace,
but have not had any success.

Any thoughts on this?

Regards,
Max Schneider.


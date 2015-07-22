From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Problem using Linux CAN
Date: Wed, 22 Jul 2015 20:39:18 +0200
Message-ID: <55AFE356.9070906@hartkopp.net>
References: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org> <55AFD5DA.7010601@hartkopp.net> <A0E5883A-3FBB-4060-8A38-A32DA743B16B@osdr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:37259 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVSjW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 14:39:22 -0400
In-Reply-To: <A0E5883A-3FBB-4060-8A38-A32DA743B16B@osdr.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Hotfilter <thotfilter@osdr.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 22.07.2015 19:52, Tim Hotfilter wrote:

> I am using a kernel image from Xilinx git hub

This is 4.0 then, right?

> and cangen to generate static load. I get this error as result in cangen after a while.

Can you send the output from

ip -details link show can0 (or whatever canX got stuck)
ip -stat link show can0 (or whatever canX got stuck)

just to see why the CAN interface gets offline.

Do you have a proper CAN setup (with CAN transceivers, real wires, 2x 120 ohms 
termination, etc) ?

Sending CAN frames only works when there's a second/different node with the 
same bitrate acknowledging the sent frame. Sending without cabling/termination 
always leads to CAN controllers that feel sad :-)

Regards,
Oliver


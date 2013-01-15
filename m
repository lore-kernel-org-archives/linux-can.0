From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: struct can_bittiming/struct can_berr_counter
Date: Tue, 15 Jan 2013 17:40:40 +0100
Message-ID: <50F58688.4050209@grandegger.com>
References: <1356821415.6901.159.camel@blackbox>  <50EB20C0.4000201@hartkopp.net> <1358022574.2504.23.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43961 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab3AOQko (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jan 2013 11:40:44 -0500
In-Reply-To: <1358022574.2504.23.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

On 01/12/2013 09:29 PM, Max S. wrote:
> Hello,
> 
> What is the reason why struct can_bittiming and struct can_berr_counter
> use __u32 for all its members?

I think mainly for user/kernel space alignment and simplicity reasons.
It has been discussed in an early phase of the project, IIRC.

> In the case of txerr and rxerr are those not even limited to 255 in the
> CAN specification?

I don't have a specication at hand but I have in mind:

    0  <  error-counter <= 127: error-active state
  128  <  error-counter <= 255: error-passive state
  256  <= error-counter       : bus-off

Wolfgang,


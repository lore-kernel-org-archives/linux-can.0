From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: FlexCAN on i.MX28 interrupt flooding retrying send
Date: Fri, 07 Mar 2014 16:36:39 +0100
Message-ID: <5319E787.5030205@grandegger.com>
References: <53197E8A.5050409@meduna.org> <5319806A.6050809@pengutronix.de> <53198609.3010605@grandegger.com> <OF203965D8.128520F3-ON86257C94.004FA84A-86257C94.0050AF36@notes.cat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:57967 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaCGPgl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Mar 2014 10:36:41 -0500
In-Reply-To: <OF203965D8.128520F3-ON86257C94.004FA84A-86257C94.0050AF36@notes.cat.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jason R1 White <White_Jason_R1@cat.com>
Cc: linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org

On 03/07/2014 03:41 PM, Jason R1 White wrote:
> Do you know why this is the case?  Is there a bug in the iMX28?  I've
> never had issues with other controls not being to handle this properly.

There are a few Flexcan core variants around which do not behave the
same way. For further information have a look to the following comment
in the Flexcan driver:

  http://lxr.linux.no/#linux+v3.13.5/drivers/net/can/flexcan.c#L147

Wolfgang.

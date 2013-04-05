From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH] can: sja1000: use common prefix for all sja1000 defines
Date: Fri, 05 Apr 2013 11:41:13 +0200
Message-ID: <515E9C39.1040808@grandegger.com>
References: <1364974929-14702-1-git-send-email-mkl@pengutronix.de> <515C8834.7040006@hartkopp.net> <515E84AF.303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44785 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab3DEJlR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Apr 2013 05:41:17 -0400
In-Reply-To: <515E84AF.303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On 04/05/2013 10:00 AM, Marc Kleine-Budde wrote:
> On 04/03/2013 09:51 PM, Oliver Hartkopp wrote:
>> I used SJA_ as prefix for all relevant defines - even for SJA1000_ defines:
> 
> I like SJA1000_ more then SJA_, but I don't insist on that... :)

Me too! A *common* prefix is nicer. If the lenght does matter I would
prefer dropping "REG_". Just the C_CAN driver uses "_REG_" as suffix.

Wolfgang.


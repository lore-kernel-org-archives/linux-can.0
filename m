From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/4] can: flexcan: use be32_to_cpup to handle the value
 of dt entry
Date: Wed, 27 Jun 2012 11:07:50 +0200
Message-ID: <4FEACD66.3020709@grandegger.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:57637 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab2F0JIC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 05:08:02 -0400
In-Reply-To: <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: mkl@pengutronix.de, davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org

On 06/27/2012 10:19 AM, Hui Wang wrote:
> The freescale arm i.MX series platform can support this driver, and
> usually the arm cpu works in the little endian mode by default, while
> device tree entry value is stored in big endian format, we should use
> be32_to_cpup() to handle them, after modification, it can work well
> both on the le cpu and be cpu.

Oops, that reminds me that other Linux-CAN (of-)drivers do require a
similar fix to work on little endian platforms. Not your business, of
course.

Wolfgang.


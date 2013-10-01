From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] net: can: c_can_platform: Remove redundant
 of_match_ptr
Date: Tue, 01 Oct 2013 12:34:47 -0400 (EDT)
Message-ID: <20131001.123447.1172971601616542676.davem@davemloft.net>
References: <1380515114-2823-1-git-send-email-sachin.kamat@linaro.org>
	<1380515114-2823-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54689 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab3JAQes (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2013 12:34:48 -0400
In-Reply-To: <1380515114-2823-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: sachin.kamat@linaro.org
Cc: netdev@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org

From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Sep 2013 09:55:14 +0530

> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied.

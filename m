Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0C23C4F2;
	Sun,  3 May 2026 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827703; cv=none; b=d7cq68HLk35PCE+CExtPqB+Ltuhn8BdDYgUXnuxxArtvGDUII8gvfkZATKzxZKObkWXPSS9JRjz8lsJ0ErIn57LJySOPdVVzu0VH1omBUr918lkqplZFxOAMrq3HSMJG2YweokR+KIimdFpsLXaDwLI3EIBgzcPw1SAhWoeNyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827703; c=relaxed/simple;
	bh=fiLiaWwKrVIjOWaSnEWgSySv6Hyt/1f/Gq3WlcytnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUYjlNnwEFZebLNajP36d0iHYCc3Tl1dmRDmFYfc+m8zCSDVMDJR2aGfVYH7drYf2bl8+CA3EfiHbhlLCfzgDPNhu9AbXFRuU6VbDDTx6s0slFBTVmoKJQC+3ZL+/DgFDypF5QzNZDyF5SC3Rc+CvY2TPR24DlMBWVb04xv6NS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDqRoans; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDqRoans"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D568C2BCB4;
	Sun,  3 May 2026 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777827703;
	bh=fiLiaWwKrVIjOWaSnEWgSySv6Hyt/1f/Gq3WlcytnLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDqRoansc7LG0FO9DJlMaR6cfChtEWl70hCLSoGRDnFHnCkaQwAenBhsF2TzVfISa
	 NXqeR+nQdHHWLLvU5DmPtFtymssVHP5VuVxpa0mGwPH7htL6DspW+U5V9z7kJrixnk
	 0e0O3bvmgP8nP0PKboyyHyNXBHHyFIhoINu4wMetgRoEZ2XEj1F2LoiGncWJ6DDhWP
	 Qp3fCc+WHA6KhKHQxBQ0gJdXGq0pojPs2M9Xxz/k5RCDapNVMjkr5uFoQ1Ieu13I+F
	 q+/y48w4rfKewY+hSdHpZwkT+5kGY4tdPYTazqRO+NwWXi8y85gbSFblD5PGcDYdr6
	 Eg85pMzHzPmAQ==
Date: Sun, 3 May 2026 22:31:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <afd_csl0eHFfVWLP@vaman>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6KwGIhpJn_2eVz@ashevche-desk.local>

On 14-04-26, 21:43, Andy Shevchenko wrote:
> On Tue, Mar 17, 2026 at 09:27:26PM +0100, Andy Shevchenko wrote:
> > The driver does two things that need to be addressed:
> > - includes subject to remove gpio.h
> > - checks for error code from device property APIs when it can be done in
> >   a robust way
> > 
> > This series addresses the above and adds a couple of additional refactoring.
> 
> Any comments on this? Doesn't look like it being applied so far...

Apart from stray delete, rest looks, fine. Can you fix that and rebase

-- 
~Vinod

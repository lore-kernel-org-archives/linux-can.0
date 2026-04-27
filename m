Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8C336892;
	Mon, 27 Apr 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303596; cv=none; b=rRqjbEAQ19gd0IAhEz2OpcQmqhIEEFE6+xu8F2xZBYRG6TcOg8q9Ozy6Myr6zgA/OS9wJh5ahCbpeY4KlWI/LIFDV7jWejeh5bM05gtRa1rtYZ+eLHeOdQ92sieFxYU/xcI8L7kK2N3/omnud5LfiMfMsYFYnVWzm3T0mgwuefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303596; c=relaxed/simple;
	bh=ULIjuYjHbAwmU6XaI+lBFkFaz6ssx3ysv2IbDMcn4no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5lQhcN5FifR5KV/P+aMVdGp02MQ/K6a1e4xF3sdvoJaAzIE6swW+dlutMlfyur6w4TmiZXPFy7yk+osP+Thq3jhrH2/HXfb5eH2ln29es7DD0J57L3zpfZcbFTbWDz5nYHdsUFhtUis21mUMQCTya4eQqR4FZ76njaqbu4uUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfzKIpBW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfzKIpBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303595; x=1808839595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ULIjuYjHbAwmU6XaI+lBFkFaz6ssx3ysv2IbDMcn4no=;
  b=TfzKIpBWTlGzcaXKuQ/OtAFNPxlWGaPRG8IGsHko19JG6umkB+Mqb09O
   BLYPq+gjREOKYLKPBG82EzvaNS/WLF2YzsNtPTmjTKZfAGJK4IW4od6Au
   oqTxZPwkYPQdRnYlPsocz/wOiDdWqTdAl07RT02RXvoOkAY8Hd3sZ9sRt
   VfBypuT/IRBuj9VQtz7KV0ZRPtskFyzeGZML6POXI7bZYr935h7aL0tdu
   pqJlZ1rtFSiC/ki3aum+Hxgfbj/y8Aa2zvVsiGpf2OX0RV0ADmsv9HS0c
   tnikAUU6UJSAA/xADDLFFOpj8PgVwvxHadQr7Sn12rkTLuh0dBTjoqtNU
   w==;
X-CSE-ConnectionGUID: w7BYRBHaQ7GnvgFL8J73TA==
X-CSE-MsgGUID: hu3Iyld4TNuMcMbu/rpcAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88794679"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="88794679"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:26:34 -0700
X-CSE-ConnectionGUID: dFKvDgC0S7+53DMdOkTEeA==
X-CSE-MsgGUID: +WNZa+T9RS+KAKKavp/61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="256980399"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:26:32 -0700
Date: Mon, 27 Apr 2026 18:26:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <ae-AJdSrnXiuc1mW@ashevche-desk.local>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <ad6KwGIhpJn_2eVz@ashevche-desk.local>
 <7bcb68c4-e4bd-4ad9-bb75-99e0845b204c@solid-run.com>
 <ae9l4n8wocbVegcJ@ashevche-desk.local>
 <5d4c3c95-cbe1-4439-8036-b014264ce8c2@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4c3c95-cbe1-4439-8036-b014264ce8c2@solid-run.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 01:41:43PM +0000, Josua Mayer wrote:
> Am 27.04.26 um 15:34 schrieb Andy Shevchenko:
> > On Mon, Apr 27, 2026 at 11:09:48AM +0000, Josua Mayer wrote:
> >> Am 14.04.26 um 20:43 schrieb Andy Shevchenko:
> >>> On Tue, Mar 17, 2026 at 09:27:26PM +0100, Andy Shevchenko wrote:

...

> >> For unknown reason your patch-set did not arrive in my inbox.
> >> Perhaps it went missing for others, too?
> > Are you in the MAINTAINERS for this part of the kernel?
> > The CAN NETWORK DRIVERS and GENERIC PHY FRAMEWORK do not list your name.
> Correct. I touched can phy once related to mux only.
> > If you think of mail delivery in general, it's delivered at least to the ML
> > https://lore.kernel.org/all/20260317203001.2108568-1-andriy.shevchenko@linux.intel.com/
> >
> > TBH I don't know what to answer to your question as I don't know your expectations and
> > how it should be fulfilled taking into account my above question...
> 
> Changelog v2:
> - Cc'ed to Ulf and Josua due to above
> 
> This is why I expected it in my inbox.
> Usually in this situation I blame my provider.

Ah, blame me then. I most likely missed to add your name to the Cc list.

> > But thanks for the reviewing! I will address the commit message in v3.
> Great!

And will try hard to make sure your address will be in the Cc list.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A385320A04;
	Tue, 14 Apr 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192206; cv=none; b=p3XD2TOGDpNAuOf42xhuxyCQPl7dSxiKlOOfwjJQLthnn9XJv8EXdXp1jstll4fh3Q/BXApo3Pjm6z4rGM9aLJS2g2rw5AcwUPCpwstLM9iw+Gk47cYpUx/HCwzGrSXjtYxPLbXvU7C/DDWKZQpdCiQ/hSYnxJvIyjFztplROQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192206; c=relaxed/simple;
	bh=G9WPXJuT87nPx3LRZm4tioyR9pDQugdVZ5fuYwKEFZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+wBMbCfVBXxpvNSHBEsXCVuK/jOia3E8PfuT9EZD/WOT+8hc6ruvsdvavPXOKt8oJ4/g9rSdZTjzAmttJJi7PNQb2slwF0zdAcpfK3A3I4TMXQMfvd43OYONNsy0056XpBkGpUVbDiS3RtYKGMe7QpFbIDlAlMCPNeM8ypWulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZMQGc4u; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZMQGc4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776192204; x=1807728204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G9WPXJuT87nPx3LRZm4tioyR9pDQugdVZ5fuYwKEFZo=;
  b=SZMQGc4uapPoi8n5cRdkFHpkjNKaraIKwXPxoYQkImVnPdm035wb3noE
   95Gsi0Og77RO94y+j7uI6PFTByZL67GF158HBbjnv89UwYhMfSyifq3wb
   vgYZdlUl05IS8EDq245MpJKQtVGpKichsOGS6t3EDRI1t146IAj3RvVZn
   cmvPd/ZWFnp1H7nJZPWKnSuzZdbgsvaH0r2zQxZezS7w9tJvgFuW/FyPp
   sI4KraAjzf5jucCOidiJ3K21EnExSMUQrH+Fm36XbQ0Btc77uS+QFMQnY
   bdjebkN1hhDO5q6NW176FjcdGfJEQPyd8ODDMaXp+lcofklmrS51ZBhkH
   Q==;
X-CSE-ConnectionGUID: 7PRLf4NZSzyXDLnilOTYow==
X-CSE-MsgGUID: 3flRxrZtTN6Ax++2i9fr+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77234767"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77234767"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:43:17 -0700
X-CSE-ConnectionGUID: Ax/JtCqtTduIB164ewpozg==
X-CSE-MsgGUID: aVhCAI69RfG0seamYT2Hgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234219869"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:43:15 -0700
Date: Tue, 14 Apr 2026 21:43:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <ad6KwGIhpJn_2eVz@ashevche-desk.local>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 17, 2026 at 09:27:26PM +0100, Andy Shevchenko wrote:
> The driver does two things that need to be addressed:
> - includes subject to remove gpio.h
> - checks for error code from device property APIs when it can be done in
>   a robust way
> 
> This series addresses the above and adds a couple of additional refactoring.

Any comments on this? Doesn't look like it being applied so far...

-- 
With Best Regards,
Andy Shevchenko



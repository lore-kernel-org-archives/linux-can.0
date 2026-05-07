Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AF3C0626;
	Thu,  7 May 2026 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146208; cv=none; b=UXx5vrZlRVzSkzPV1tkqTNn8Z/f2I2R2+eyMROXkbE6X8mIxjr18sUlK8OXAxt+v6anrKPLl4jY6XEbBdGRiMYrVqomPjEpOjncUrPOVBieFnS3mRdkLwUmsbh94xChTeud1vBJgg9tD0nKTJ1zb36YUw79KdzqTmYMDK63mUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146208; c=relaxed/simple;
	bh=hVRt+EAWGZVEQz7LOHcYNX6mPd9YkZtZrgHEgkxI9CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEOUIEdTqYUj6FMjtIkeq1QdbzafXb+UKJsYmpsbhifqhIOTwbptJldsOin7phLJQXVemStH+0M2rK1Hh7LqatndiGAlvHkbDORT0VeKgEjt/Q1+MOQ0mCts+uLCMt0nkNlVQjbkoUDq9GiTHFDZMtaVzlnuNuAfXAU/+SqN7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IiMxxy4U; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IiMxxy4U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WHxYVQsjtbfSlN5AZ3VKGsGbC3uLpkeeoyWo9tT19ng=; b=IiMxxy4UQJ69rcHVkCNVXemjTY
	+wPHs5BxgYds22l4qyHm/FBuLNIRyx800VWSmGl2ipW7N7cmu+LQt4hHUEYxie3sThqQeUPXby41x
	wzCNRar3ruj94VgT4jjU988b9ukEmWUDs3dmLfUmrpkGyJzE8myfwyD2qSiqhynpk85GzqZvos9Xm
	6hTHxtDlqaLNlh8Jn6QrqoxTSu5KHndjuWyUMbauUzFoAcv+uAsaJ+JJiX8EUAD8LtYx0k1jCrwi6
	wEubKCEB8i0c2hMwUVAUquqgT1EkNMx2iYqGbOeMMu2EUb9OGsBK0il+nf53sGl6bmhr/i6oR/5L3
	11eZaYuQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wKv3C-004Gkj-0h;
	Thu, 07 May 2026 09:29:46 +0000
Date: Thu, 7 May 2026 02:29:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 4/5] llc: convert to getsockopt_iter
Message-ID: <afxbT1ylYWnih_f4@gmail.com>
References: <20260505-getsock_two-v1-0-4cb0738950e0@debian.org>
 <20260505-getsock_two-v1-4-4cb0738950e0@debian.org>
 <20260506172525.27323c23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506172525.27323c23@kernel.org>
X-Debian-User: leitao

On Wed, May 06, 2026 at 05:25:25PM -0700, Jakub Kicinski wrote:
> On Tue, 05 May 2026 04:12:41 -0700 Breno Leitao wrote:
> > Convert LLC socket's getsockopt implementation to use the new
> > getsockopt_iter callback with sockopt_t.
> > 
> > Key changes:
> > - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> > - Use opt->optlen for buffer length (input) and returned size (output)
> > - Use copy_to_iter() instead of put_user()/copy_to_user()
> > - Add linux/uio.h for copy_to_iter()
> 
> kdoc needs to be adjusted here.

Good catch, I will update!

> When you repost could you split the CAN stuff out and send it 
> to Marc and co. ? We don't normally take CAN patches directly.

Ack, I will split this series in two, one for CAN and one for non-CAN
drivers.

Thanks for the review,
--breno

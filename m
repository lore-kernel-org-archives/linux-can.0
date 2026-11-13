Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794567126;
	b=2BR705G2g0l//kYCVJgg9RetXCVWEp9N3Qif8DybKUUFCCjY24y4t0GOQQBO80gHSL1n
	 iHxqXliz0dGfgE13YgOis2Z3CKC35zj+zSroc5AliIc2J7nnCqqeBYVsvNI6KOkSStEDL
	 5YS2bxknTiufTUWY1g+XRMSpfmMsyaH6WtQunuAMT2wIXblCvu9RZa5wcreyO4cNN6+7f
	 Ol7G8+S/WHiXlxQpcW9CamdQYnzAjLBuowmiYYz5PbiR8ucvJA0chCRc4GMxZf7LBOus2
	 rjGQV0p31OdTmw5jmZBjc1gBS3NaN4saQUWdZZiNVkiFU/B5MWohY81sh94OoWSyP6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567126;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=N6aK7nkX81X7KXgOZagyPtYlxR/eDLFpDDClAbyvTRs=;
	b=u+k+PAnG9r8EeKML5V7BbRTspRVRrF+08FD7sG/gShN3Aeh9XayCMDp5kdVDzQ8pLBNn
	 3C8YNFI2Fz/lfC/fayElsI7j7jkILpvyLJYjNAmVyqRLyhIBqiiMclncJHccdPl37oWAS
	 fDGvb3VG5lCSSesO7qOvh30VOIw6Y65RkzBCEta6cW0Qw9D9IadNc3Nrv5CV52OZnZj5F
	 sK11g8FgqTGwtXGsCHYpYyi5OWxUEkUML7ZVI+ali8dBTrDOQvXz+1J4HAYkOFGC38WAx
	 yuCrh/kuxj++HmZRFwxTzsGwtdqg4PV9EfrGBeK1XGJKQbkH9R4xyude5CDucQkgXQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jlsPDxOc;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Zg8A+E3K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E177606A33D
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E177606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jlsPDxOc;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Zg8A+E3K
ARC-Seal: i=1; a=rsa-sha256; t=1794567115; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JDqoeiPRIgZHDRFL+TOFJprvJLNvdYmX+gfC8Yv+xyRwZz1s11HNtDneXLNzPhN92D
    53Gx4UQt7D7THNADhRJX/iP9MCxhqGZco2MVroDVFt4m3Vl/QQLXdWmrI3cPYXnrK3sf
    fTNmwVvGdYzJqO9iLNWji2nuGMpfrRX5yEIhjaSB8wh5EMT9qA3JX8f01lUGRlxcvyJr
    g89ViXgSr1hdP1StBj+lioN6wH9wFnqk+ZAlDiF8zIIbXlyZP9o1ElnKXnzNetIgMbi9
    G+k5SuiCULcaUep8WKrD+IQEPazL8mbSQnFBCuSsmsB1WiY76H9TZMF7XaCyjJrlwDBE
    S7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794567115;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N6aK7nkX81X7KXgOZagyPtYlxR/eDLFpDDClAbyvTRs=;
    b=a+KPPlfqLUNJiFRuGiETb5BqCurRpHROImmSrhLUSwI/IV52p2g/2HplpeRhW0dh0g
    NsLSYvIVTsVIZA6tUVnb6DlrvBIoUZkKdPKa++1xlVO+lA7gAmjiCLwL4Qr6/kUaPm9i
    IY0JcnGHJAOwR4I8y3T6pzaFhSkOGkJxZeBPgRt1HC9K+jJ4LMtAVxeaBdUqElLZNQEH
    f8YBjNfFOgm/62yo8ZMeLTy9mrMK0k+1cFO5ynRE6hZ9G6jgvRJkiHkLMipdiwxay6E+
    Yk27B9RPyu7qA2Nbiqd541mdhE+Ia/9zEy+ZhKPdw/EUKO42kKDdZFKchHkF9QqykIax
    qlTg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794567115;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N6aK7nkX81X7KXgOZagyPtYlxR/eDLFpDDClAbyvTRs=;
    b=jlsPDxOcEE+dPYipWGTKJ4DYVFzpPjG4tH/rTuthYwFf+56/H3eo9U6HmLvL45Zdar
    K3uYF3nY0hE1QW2cyDnJkOilLxCau58bzI/56lDrTOhKeyrgYG48uF9evUjqxTdHg43c
    E+gfN3XG6xbzanutD2UoP/Y+EC6Pa+yXEs/N3jFCiahkp4b2cfJ6UJwNFyJMBEZn5IXs
    QRgLPs0ztRkv4OXzdqb7kJiv0YQDZ+jiCX5irDbJJ+n6pgIidYyvnxanYFltrLiENsGS
    DWwbC1GYLorZx+Y705lEhGSBGgnFNh1ZUTuQh5WZeycBtEmyl356aZry8fRzKj8d0M80
    glcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794567115;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N6aK7nkX81X7KXgOZagyPtYlxR/eDLFpDDClAbyvTRs=;
    b=Zg8A+E3KVr3Ew02lBzI127k2pbwIda3zWsuScyZebMdKv/dBjTK6O6hnu3JJ5m74LX
    AspnsZWCLbOU+e1b4ECg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ADAptIxs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 13 Nov 2026 11:51:55 +0100 (CET)
Message-ID: <5b2f1dcd-292e-42fe-91f7-fe0255e830ab@hartkopp.net>
Date: Fri, 13 Nov 2026 11:51:55 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] can: raw: use a private mutex instead of
 lock_sock()
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261111-can-bcmlock-memcg-v4-3-5428607a608f@hartkopp.net>
 <179454426541.488853.15379643605511531742@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179454426541.488853.15379643605511531742@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.11.26 05:31, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The comment this patch adds to struct raw_sock, 'struct mutex
>    conf_lock; /* protects bind, filters and sockopts */'…

Changed comment and commit message in v5:

struct mutex conf_lock; /* protects bind, filters and setsockopt */

https://lore.kernel.org/linux-can/20261113-can-bcmlock-memcg-v5-3-634c0e04bc72@hartkopp.net/

Especially:

Sashiko suggested to hold not only the filter copy in raw_getsockopt()
under the new conf_lock mutex but to also protect ro->raw_vcid_opts.
This change will be addressed in a follow-up patch as it goes beyond a
simple lock replacement intended for stable.
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the bug class
>    the series is fixing is still reachable through CAN J1939 at the end…

Read the f*cking cover letter before tagging things to be [High]!

"CAN_J1939 still takes lock_sock() under RTNL in its netdev notifier and
has the same issue with the generic socket options. This is not
addressed by this series and will be handled separately once the
currently discussed j1939 patches have been merged."

Thanks,
Oliver

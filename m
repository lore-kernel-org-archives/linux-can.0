Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808B35E950
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028723; cv=none; b=C4STg0pPzdeR6Us4OEsbOM9Ipce82v9aHh63TjA4Z58EF5a3rMUmAf6hYmgKO4zs+pGQ7jp9oS+fVHxLU8Uy/hd9FF++qLHxJogb8czVVVOzUNZ6whWvDBcFc/EH7jwjGlRyTOg2EU6g3bwAHIIxpT7nG3H/1v4M/xR81pEHh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028723; c=relaxed/simple;
	bh=q+1jYsWWMZtHo/ThaUj70I3+0mqhQsdzymrgtfRry+o=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=O+CJHEbMaAofLn02+5cLxnKTfwlzLk7eX6ROo8pogObL+RaKdDKfDrvpzN7/+ZE9M9s9ZNZPVBP5aOGqTFZUSmMGvZ8InGlCI1Fndkaj6WKMyNRUpPnIRl/CUOlMCXzMa1NbNIpl5fxqZWbk8OM3Rf3EGgEyNZ/QeqlNU57ULrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=R4Pvodp0; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="R4Pvodp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792028715; bh=q+1jYsWWMZtHo/ThaUj70I3+0mqhQsdzymrgtfRry+o=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=R4Pvodp0pbQlHBG/TbD+J3GAq9GyfTXXGXnwi2LilTxy7MVgayOxc/kK8ArebBk1/
	 ZqYzuA1tlWANydVmhO4gwEgJXjmV1VymG2kJvQRdJ7U4oalx25jlnz1wjz8zdjKx0W
	 2QvpfcCOybeP9BQV5193br+Vy5Mk9NmT4lbwOrCQ=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: N8i9SvusUD3b+dAYyUyG0NvcSPnwCy+TyK+8PlgviyB2FL3SnhetYjF6bA4926
	 ZC50asIb49oJS5DRDzO81pAkEFKmlwZJJp3GXmEEMvGk9ZMi4h6030HCIC2dma1QCBZElMxopquh+
	 9Vxg6F4Lx28q9glZTHdXCXIj+R0ASKRNGdFFwox7KwNemgFxp1Sy1g9frB13AxRhSeNy/ZkXmK8pL
	 2FI1Iud6zVCS1dlk51F9/BYiFANnj0eSkmgnBTPgEYN4tOgbINE4cukvB7Lc4vjKW5Ir4WUuKLAP+
	 kPGjhEY+kAd/gG30M7qbf6YqPGh8nJV6q91GiCpWIl/9eHDuM4y7T4JujZVwfPBSQZZ++dwtF0gcN
	 6vLBuiAlRFoVM5Csczz+H72vaCUdfUl7BCXeHgcQIFFFKVOJBk2z9DKeke3CqCpXBLOi9/VXc7sLZ
	 iR9nDhsGj2ISdgjZDIKJxFEp5GHj/TIYAKguPt32AspUVZBV2Ik7zGPEpwLPKIzJtDjufHashQTNy
	 3veriM83i27t885LNAXTNjNo5TNJC1b8GeEK/nqSUxmaGWL1ZJDDLh3qI6VT1yjU361eFH5UVn4Oj
	 cILndqH9dU/7NiHx8PnafLpqF1SNhCUAJIXGFV9111BwDlfsBtibFd/g0OgUjbgjtReSZi8TQtBCD
	 eLzjw5LcBISXlxd4Ab5/CKm96ctGPjIFOdz34au4kYP9mvBi9crLRbCMeEKIFiuHMClBWE123uI40
	 1mX83XieC+J9huBngtX9Ypd1n5aV8TpDchQINi0O+yGfH5EF6nfUHmtUJKMUccmP5yOUp6vPMiqO2
	 ri1/XFMh3aalLkj9LTZqbn15f7D8iIXdIPoLWMgV8iYE3UQzNnfLOuBkNnoX9tMEdAjZUbIfxKwhB
	 UDbJno/u/8qkSg2a5swiVrEeCsyQpP8v8AZS2eaRV6n6mLB2xgFM/s6P6TusDS7B5+PHj9ho/gz1G
	 8Cl01ZLTkFeJlm1ByAY0KM0anvJyteitRp2ufxp4/VtWWSvkzK3JL6FWPC8WtgkJSlPW/vADQs3Qp
	 Xlxm3P0hx1FzN/4vMrSffw2XL5YUphZrB7qjX
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>
Subject: Re: [PATCH net v3 3/5] can: rockchip_canfd: cancel bus-off restart before closing the device
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 15 Oct 2026 09:45:13 +0800
X-Priority: 3
Message-ID: <tencent_3E11F7FD7E9B846806656E12AA46E0025C09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com>
 <20261014-rockchip-canfd-restart-close-v3-3-f0eb41090242@qq.com>
	<sashiko-outbox-171362@kernel.org>
In-Reply-To: <sashiko-outbox-171362@kernel.org>
X-QQ-mid: xmsezb41-0t1792028713tyyx71sn9

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IExhdGVyIGluIHRoaXMgZnVuY3Rpb24sIHBt
X3J1bnRpbWVfcHV0KG5kZXYtPmRldi5wYXJlbnQpIGlzIGNhbGxlZC4KPiAKPiBTaW5jZSBw
bV9ydW50aW1lX3B1dCgpIHF1ZXVlcyBhbiBhc3luY2hyb25vdXMgaWRsZSByZXF1ZXN0LCBp
dCBjYW4gbGVhdmUgdGhlCj4gaGFyZHdhcmUgYWN0aXZlLgoKWWVzLCB0aGVyZSBpcyBhIHJh
Y2UgaGVyZS4gSWYgcG1fcnVudGltZV9kaXNhYmxlKCkgY2FuY2VscyB0aGUgcGVuZGluZwpy
ZXF1ZXN0IGJlZm9yZSBydW50aW1lIHN1c3BlbmQgcnVucywgdGhlIGNsb2NrcyBjYW4gcmVt
YWluIGVuYWJsZWQgYWZ0ZXIKdGhlIGRyaXZlciBpcyByZW1vdmVkLgoKPiBDb3VsZCB0aGlz
IGJlIGEgcmVncmVzc2lvbj8gU2hvdWxkIHBtX3J1bnRpbWVfcHV0X3N5bmMoKSBiZSB1c2Vk
IGluCj4gcmtjYW5mZF9zdG9wKCkgaW5zdGVhZCBvZiBwbV9ydW50aW1lX3B1dCgpIHRvIGVu
c3VyZSB0aGUgaGFyZHdhcmUgaXMgc3VzcGVuZGVkCj4gYmVmb3JlIHBtX3J1bnRpbWVfZGlz
YWJsZSgpIGNhbmNlbHMgdGhlIHdvcms/CgpUaGlzIGlzIGFuIGV4aXN0aW5nIGJ1Zy4gVGhl
IHNhbWUgUE0gY2FsbHMgYW5kIG9yZGVyaW5nIHdlcmUgYWxyZWFkeQpwcmVzZW50IGluIGZm
NjBiZmJhZjY3ZiAoImNhbjogcm9ja2NoaXBfY2FuZmQ6IGFkZCBkcml2ZXIgZm9yIFJvY2tj
aGlwCkNBTi1GRCBjb250cm9sbGVyIikuIFRoaXMgc2VyaWVzIGRvZXMgbm90IGNoYW5nZSB0
aGVtIG9yIG1ha2UgdGhpcyBidWcKd29yc2UuCgpJIHdpbGwgbGVhdmUgdGhpcyBpc3N1ZSBv
dXQgb2YgdGhlIGN1cnJlbnQgc2VyaWVzIGZvciBub3cuIElmIEkgaGF2ZQp0aW1lIGxhdGVy
LCBJIHdpbGwgZm9sbG93IHVwIHdpdGggYSBzZXBhcmF0ZSBmaXguCgpUaGFua3MgZm9yIHBv
aW50aW5nIHRoaXMgb3V0LgoKUmVnYXJkcywKQ3VuaGFvIEx1Cg==


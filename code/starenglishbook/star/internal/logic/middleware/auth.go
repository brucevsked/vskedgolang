package middleware

import (
	"context"
	"net/http"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/golang-jwt/jwt/v5"
)

func Auth(r *ghttp.Request) {
	var tokenString = r.Header.Get("Authorization")
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		// 从配置文件读取 JWT 密钥
		jwtSecret := g.Cfg().MustGet(context.Background(), "jwt.secret").String()
		return []byte(jwtSecret), nil
	})
	if err != nil || !token.Valid {
		r.Response.WriteStatus(http.StatusForbidden)
		r.Exit()
	}
	r.Middleware.Next()
}
